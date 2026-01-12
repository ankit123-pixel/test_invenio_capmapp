using { anubhav.db.master } from '../db/datamodel';


service MyService @(path: 'MyService'){
        function  hello(name:String)
            returns String;

            //@readonly
            @Capabilities : { Updatable:false, Deletable:false, Insertable:false }
            entity ReadEmployeeSrv as projection on master.employees
    

}