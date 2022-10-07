/**
*  Description     :  This is Assignment 3 apex class and in this we will entering the values in map
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/11/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
**/
public with sharing class Assignment3 {

    /**
    * 
    *   @description    :   In this method we are we are entring the values in Map<string, string>
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/11/2021 - Rajat khatri
    * 
    **/
    public static void methodOne(){
        Map<string, string> strToStr = new Map<string, string> {'Rohit' => 'Sharma', 'Shubman' => 'Gill'};
        strToStr.put( 'Cheteshwar', 'Pujara');
        strToStr.put('Ajinkya', 'Rahane');
        System.debug('strtostr: ' + strToStr);
    }
    /**
    * 
    *   @description    :   In this method we are we are entring the values in Map<string, List<string>>
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/11/2021 - Rajat khatri
    * 
    **/
    public static void methodTwo(){
        Map<string, List<string>> strToList = new Map<string, List<string>> {
            'Rohit' => new List<string> {'Batsman', 'Right-hand', 'India'},
            'Shubman' => new List<string> {'Batsman', 'Right-hand', 'India'},
          'Cheteshwar' => new List<string> {'Batsman', 'Right-hand', 'India'}};
            strToList.put('Ajinkya', new List<string> {'Batsman', 'Right-hand', 'India'});
            strToList.put('Rishabh', new List<string> {'Batsman', 'Left-hand', 'India'});

            System.debug('strToList: '+ strToList);
    }
    /**
    * 
    *   @description    :   In this method we are we are entring the values in Map<string,Map<string,string>>
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/11/2021 - Rajat khatri
    * 
    **/
    public static void methodThree(){
        Map<string,Map<string,string>> strToStrToSTr = new Map<string,Map<string,string>>{
            'Rohit' => new Map<string,string> { '100' => '39','50' => '74'},
            'Shubman' => new Map<string,string> { '100' => '0','50' => '1'},
            'Cheteshwar' => new Map<string,string> { '100' => '18','50' => '25'}};
            strToStrToSTr.put('Ajinkya', new Map<string,string> { '100' => '15','50' => '47'});
            strToStrToSTr.put('Rishabh', new Map<string,string> { '100' => '2','50' => '5'});
            System.debug('strToStrToSTr: ' +  strToStrToSTr);
        }
        /**
    * 
    *   @description    :   In this method we are we are entring the values in  Map<string,Map<string, List<string>>>
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/11/2021 - Rajat khatri
    * 
    **/
    public static void methodFour(){
        Map<string,Map<string, List<string>>> strToStrTolSTr = new Map<string,Map<string, List<string>>>{
            'Rohit' => new Map<string,List<string>> { '100' => new List<string> {'Australia', 'England'},'50' => new List<string> {'Australia', 'England', 'Bangladesh'}},
            'Shubman' => new Map<string,List<string>> { '100' => new List<string> {'not yet'},'50' => new List<string> {'Australia'}},
            'Cheteshwar' => new Map<string,List<string>> { '100' => new List<string> {'Australia', 'England','Banglades','South Africa'},'50' => new List<string> {'Australia', 'England', 'West Indes'}}};
            strToStrTolSTr.put('Ajinkya', new Map<string,List<string>> { '100' => new List<string> {'Australia', 'England','Sri Lanka'},'50' => new List<string> {'Australia', 'England', 'Bangladesh', 'Sri Lanka'}});
            strToStrTolSTr.put('Rishabh', new Map<string,List<string>> { '100' => new List<string> {'pakistan', 'England','Sri Lanka'},'50' => new List<string> {'New zealand', 'England', 'Bangladesh', 'Sri Lanka'}});
            System.debug('strToStrTolSTr: ' +  strToStrTolSTr);
    }
    /**
    * 
    *   @description    :   In this method we are we are entring the values in Map<string,Map<string,Map<string,List<string>>>>
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/11/2021 - Rajat khatri
    * 
    **/
    public static void methodFive(){
        Map<string,Map<string,Map<string,List<string>>>> strToStrToStrToStr = new Map<string,Map<string,Map<string,List<string>>>>{
            'Rohit' => new Map<string,Map<string,List<string>>> { '100' => new Map<string,List<string>> {'Australia' => new List<string>{'2021','2018'},'England' => new List<string>{'2019','2017'}}, '50' =>new Map<string,List<string>> {'Australia' => new List<string>{'2021','2018'},'England' => new List<string>{'2019','2017'}}},
            'Shubman' => new Map<string,Map<string,List<string>>> { '100' => new Map<string,List<string>> {'Australia' => new List<string>{'NOT YET'},'England' => new List<string>{'NOT YET'}}, '50' =>new Map<string,List<string>> {'Australia' => new List<string>{'2021'},'England' => new List<string>{'NOT YET'}}},
            'Cheteshwar' => new Map<string,Map<string,List<string>>> { '100' => new Map<string,List<string>> {'Australia' => new List<string>{'2021','2018'},'England' => new List<string>{'2019','2017'},'South Africa' => new List<string>{'2018','2016'}}, '50' =>new Map<string,List<string>> {'Australia' => new List<string>{'2021','2018'},'England' => new List<string>{'2019','2017'}}}};
            strToStrToStrToStr.put('Ajinkya', new Map<string,Map<string,List<string>>> { '100' => new Map<string,List<string>> {'Australia' => new List<string>{'2021','2018'},'England' => new List<string>{'2019','2017'},'South Africa' => new List<string>{'2018','2016'}}, '50' =>new Map<string,List<string>> {'Australia' => new List<string>{'2021','2018'},'England' => new List<string>{'2019','2017'},'Sri Lanka' => new List<string>{'2017','2014'}}});
            strToStrToStrToStr.put('Rishabh', new Map<string,Map<string,List<string>>> { '100' => new Map<string,List<string>> {'Australia' => new List<string>{'2021','2018'},'England' => new List<string>{'2019','2017'},'South Africa' => new List<string>{'2018','2016'}}, '50' =>new Map<string,List<string>> {'Australia' => new List<string>{'2021','2018'},'England' => new List<string>{'2019','2017'},'Sri Lanka' => new List<string>{'2017','2014'}}});
            System.debug('strToStrToStrToStr: ' +  strToStrToStrToStr);
    }
    /**
    * 
    *   @description    :   In this method we are we are entring the values in Map<Id,Account>
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/11/2021 - Rajat khatri
    * 
    **/
    public static void methodSix(){
        Map<Id,Account> idToAcc = new Map<Id,Account>([SELECT Name FROM Account]);
        System.debug('idToAcc: ' + idToAcc);
    }
    /**
    * 
    *   @description    :   In this method we are we are entring the values in Map<Id,List<Contact>>
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/11/2021 - Rajat khatri
    * 
    **/
    public static void methodSeven(){

        Map<Id,List<Contact>> idToLCon = new  Map<Id,List<Contact>>();
        List<Contact> acc = [SELECT Id from Contact];
        for(Contact a : acc){
            idToLCon.put(a.Id, new List<Contact>([SELECT Name FROM Contact WHERE Id=:a.Id]));
        }
        System.debug('idToLCon: ' + idToLCon);

    }   
}