//
//  FMDBManager.swift
//  Langu.ag
//
//  Created by Huijing on 14/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//



import Foundation
import FMDB
import SwiftyJSON

class FMDBManager{
    
    var fileURL: URL!
    var database : FMDatabase!
    
    init(){
        
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(Constants.DB_NAME)
        
        database = FMDatabase(path: fileURL.path)
        if(database == nil)
        {
            return
        }
        createTables()
        
    }
    
    
    func createTables()
    {
        
        database.open()
        do {
            let dataModel = LocalDataModels()
            try database.executeUpdate(createTableString(tableName:dataModel.TBL_CATEGORY, tableObject: dataModel.getKeys(dataModel.TBL_CATEGORY), primaryKey: dataModel.getPrimaryKey(dataModel.TBL_CATEGORY)), values: nil)
            try database.executeUpdate(createTableString(tableName:dataModel.TBL_SKILL, tableObject: dataModel.getKeys(dataModel.TBL_SKILL), primaryKey: dataModel.getPrimaryKey(dataModel.TBL_SKILL)), values: nil)
            try database.executeUpdate(createTableString(tableName:dataModel.TBL_SKILL_TAG, tableObject: dataModel.getKeys(dataModel.TBL_SKILL_TAG), primaryKey: dataModel.getPrimaryKey(dataModel.TBL_SKILL_TAG)), values: nil)
            try database.executeUpdate(createTableString(tableName:dataModel.TBL_TAG, tableObject: dataModel.getKeys(dataModel.TBL_TAG), primaryKey: dataModel.getPrimaryKey(dataModel.TBL_TAG)), values: nil)
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
        
    }
    
    func emptyTables()
    {
        
        database.open()
        do{
            let dataModel = LocalDataModels()
            try database.executeUpdate("DROP TABLE " + dataModel.TBL_CATEGORY, values: nil)
            try database.executeUpdate("DROP TABLE " + dataModel.TBL_SKILL, values: nil)
            try database.executeUpdate("DROP TABLE " + dataModel.TBL_SKILL_TAG, values: nil)
            try database.executeUpdate("DROP TABLE " + dataModel.TBL_TAG, values: nil)
        }
        catch{
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
    }
    
    func createTableString(tableName: String, tableObject: [String: String], primaryKey: String) -> String{
        //let tableDict  = tableObject as! NSDictionary
        //let keys = tableDict.allKeys
        var resultString = "CREATE TABLE IF NOT EXISTS " + tableName + "("
        for (key, value) in tableObject{
            if(key != primaryKey){
                resultString = resultString + key + " " + value + " ,"
            }
            else{
                resultString = resultString + key + " " + value + " PRIMARY KEY ,"
            }
        }
        
        resultString.remove(at: resultString.index(before: resultString.endIndex))
        resultString.append(")")
        return resultString
    }
    
    func insertRecord(tableObject: [String: String], tableName: String, tableData: JSON, primaryKey: String) {
        
        database.open()
        let keys = tableObject.keys
        
        var insertString = "INSERT INTO \(tableName) "
        var keysString = "("
        var valuesString = "("
        
        for key in keys{
            
            keysString.append("\(key),")
            valuesString += " '"
            var valueString = "\(getValue(value: tableData, type: tableObject[key]!, key: key))"//"\(tableData[key])"
            valueString = valueString.replacingOccurrences(of: "'", with: "''")
            
            valuesString += valueString + "' ,"
            
        }
        keysString.remove(at: keysString.index(before: keysString.endIndex))
        keysString.append(") values ")
        
        valuesString.remove(at: valuesString.index(before: valuesString.endIndex))
        valuesString.append(")")
        
        insertString.append(keysString)
        insertString.append(valuesString)
        
        do{
            try database.executeUpdate(insertString, values: nil)
        }
        catch{
            print("failed: \(error.localizedDescription)")
        }
        database.close()
        
    }
    
    
    
    func UpdateRecord(tableObject: Any?, tableName: String, tableData: Any,  matchKeys:[String]){
        
        database.open()
        let tableDict = tableObject as! NSDictionary
        let keys = tableDict.allKeys
        
        let values = tableData as! NSDictionary
        var insertString = "UPDATE \(tableName) SET "
        var valuesString = ""
        var matchItemsCompareString = " WHERE "
        for matchKey in matchKeys{
            matchItemsCompareString += "\(matchKey as AnyObject) = '\(values[matchKey] as AnyObject)' AND "
        }
        matchItemsCompareString.append("====")
        matchItemsCompareString = matchItemsCompareString.replacingOccurrences(of: "AND ====", with: "")
        
        for key in keys{
            var valueString = ""
            
            
            valuesString += "\(key) = '"
            valueString = "\(values[key] as AnyObject)"
            valueString = valueString.replacingOccurrences(of: "'", with: "''")
            valueString.append("'")
            
            valuesString += valueString + " ,"
            
        }
        
        valuesString.remove(at: valuesString.index(before: valuesString.endIndex))
        insertString.append(valuesString.replacingOccurrences(of: ")',", with: "',"))
        insertString.append(matchItemsCompareString)
        
        do{
            try database.executeUpdate(insertString, values: nil)
        }
        catch{
            print("failed: \(error.localizedDescription)")
        }
        database.close()
        
    }
    

    
    func getDataFromFMDB(with query: String, tableObject: [String: String]) -> [[String: AnyObject]]{
        
        var result = [[String: AnyObject]]()
        database.open()
        do{
            let rs = try database.executeQuery(query, values: nil)
            
            while rs.next(){
                var resultItem : [String: AnyObject] = [:]
                for item in tableObject{
                    resultItem[item.key] = getObjectFromKey(value: rs, type: item.value, key: item.key)
                }
                result.append(resultItem)
            }
            
        }catch {
            print("failed: \(error.localizedDescription)")
        }
        database.close()
        return result
    }
    
    func getObjectFromKey(value: FMResultSet, type: String, key: String) -> AnyObject{
        
        if (type.hasPrefix("VARCHAR") || type.hasPrefix("TEXT")){
            return value.string(forColumn: key) as AnyObject
        }
        else if(type.hasPrefix("TINYINT")){
            return value.bool(forColumn: key) as AnyObject
        }
        else if(type.hasPrefix("BIGINT")){
            return value.longLongInt(forColumn: key) as AnyObject
        }
        else if(type.hasPrefix("INT"))
        {
            return Int(value.string(forColumn: key)!) as AnyObject
        }
        else if(type.hasPrefix("DOUBLE"))
        {
            return Double(value.string(forColumn: key)!) as AnyObject
        }
        return "" as AnyObject
    }
    
    func getValue(value: JSON, type: String, key: String) -> Any {
        
        if (type.hasPrefix("VARCHAR") || type.hasPrefix("TEXT")){
            return value[key].nonNullStringValue
        }
        else if(type.hasPrefix("TINYINT")){
            return value[key].nonNullIntValue
        }
        else if(type.hasPrefix("BIGINT")){
            return value[key].nonNullInt64Value
        }
        else if(type.hasPrefix("INT"))
        {
            return value[key].nonNullIntValue
        }
        else if(type.hasPrefix("DOUBLE"))
        {
            return value[key].nonNullDoubleValue
        }
        return ""
    }
    
    func executeQuery(_ query: String) {
        database.open()
        do {
            try database.executeQuery(query, values: nil)
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        database.close()
    }
    
}


var fmdbManager = FMDBManager()
