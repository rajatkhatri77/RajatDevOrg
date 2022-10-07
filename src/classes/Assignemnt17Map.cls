public class Assignemnt17Map {
    
    public static Map<String,Map<String,List<String>>> mapOfCountryWithStateAndDistrict = new Map<String,Map<String,List<String>>>();
    public Assignemnt17Map(String word){
        System.debug('in constructor');
        List<String> listOfCountryStateDistrict = new List<String>();
        List<State__c> statesRollUpToUpdate = new List<State__c>();
        List<Country__c> countryRollupToUpdate = new List<Country__c>();
        
        //Aggraget query for updating the State Total No of District
        AggregateResult[] districtAggregateResultForState = [SELECT Count(Id) Total_District, State_Name__c
                                   FROM District__c GROUP BY State_Name__c];
        for(AggregateResult ar : districtAggregateResultForState){
            State__c state = new State__c();
    		state.Id = (Id)ar.get('State_Name__c');
    		state.Total_Number_of_Districts__c = (Integer)ar.get('Total_District');
    		statesRollUpToUpdate.add(state);
        }
        //checking list is not empty befor DML
        if(statesRollUpToUpdate.size()>0){
            update statesRollUpToUpdate;
        }
        
        AggregateResult[] stateAggregateResultForCountry= [SELECT Count(Id) total_State, 
                                                           Sum(Total_Number_of_Districts__c) sumOfTotalDistricts, 
                                                           Country_Name__c 
                                                           FROM State__c GROUP BY Country_Name__c];
        for(AggregateResult ar : stateAggregateResultForCountry){
            Country__c country = new Country__c();
    		country.Id = (Id)ar.get('Country_Name__c');
    		country.Total_Number_of_States__c = (Integer)ar.get('total_State');
    		country.Total_Number_of_Districts__c = (Decimal)ar.get('sumOfTotalDistricts');
            countryRollupToUpdate.add(country);
        }
        
        if(countryRollupToUpdate.size()>0){
            update countryRollupToUpdate;
        }
        
        /*List<Country__c> countryList = [Select Name,Total_Number_of_Districts__c,Total_Number_of_States__c 
                                        From Country__c];
        List<State__c> stateList = [Select Name,Total_Number_of_Districts__c,Country_Name__r.Name 
                                    From State__c];*/
        List<District__c> districtList = [Select Name,State_Name__r.Name,State_Name__r.Country_Name__r.Name From District__c];
        if(districtList.size() > 0){
            for(District__c district : districtList){
                if(!mapOfCountryWithStateAndDistrict.containsKey(district.State_Name__r.Country_Name__r.Name)){
                    mapOfCountryWithStateAndDistrict.put(district.State_Name__r.Country_Name__r.Name, new Map<String,List<String>>()); 
                }
                if(!mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).containsKey(district.State_Name__r.Name)){
                    mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).put(district.State_Name__r.Name, new List<string>());
                }
                if(!mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).get(district.State_Name__r.Name).contains(district.Name)){
                    mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).get(district.State_Name__r.Name).add(district.Name);
                    if(district.State_Name__r.Country_Name__r.Name.startsWithIgnoreCase(word)){
                        if(district.State_Name__r.Name.startsWithIgnoreCase(word)){
                            if(district.Name.startsWithIgnoreCase(word)){
                                listOfCountryStateDistrict.add(district.State_Name__r.Country_Name__r.Name + ' - ' + district.State_Name__r.Name + ' - ' + district.Name);
                            }
                        }
                    }
                }
            }
        }
        System.debug('Mappp -> ' + mapOfCountryWithStateAndDistrict);
        System.debug('listOfCountryStateDistrict -> ' + listOfCountryStateDistrict);
        
        
        /*for(Country__c country : countryList){
            if(!mapOfCountryWithStateAndDistrict.containsKey(country.Name)){
                mapOfCountryWithStateAndDistrict.put(country.Name, new Map<String,List<String>>());
                for(State__c state :stateList){
                    if(mapOfCountryWithStateAndDistrict.containsKey(state.Country_Name__r.Name)){
                        if(!mapOfCountryWithStateAndDistrict.get(state.Country_Name__r.Name).containsKey(state.Name)){
                            mapOfCountryWithStateAndDistrict.get(state.Country_Name__r.Name).put(state.Name, new List<String>());
                        }
                        for(District__c district : districtList){
                            if(mapOfCountryWithStateAndDistrict.containsKey(district.State_Name__r.Country_Name__r.Name)){
                                if(mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).containsKey(district.State_Name__r.Name)){
                                    if(!mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).get(district.State_Name__r.Name).contains(district.Name)){
                                        mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).get(district.State_Name__r.Name).add(district.Name);
                                        if(district.State_Name__r.Country_Name__r.Name.startsWithIgnoreCase(word)){
                                    		if(district.State_Name__r.Name.startsWithIgnoreCase(word)){
                                        		if(district.Name.startsWithIgnoreCase(word)){
                                            		listOfCountryStateDistrict.add(district.State_Name__r.Country_Name__r.Name + ' - ' + district.State_Name__r.Name + ' - ' + district.Name);
                                        		}
                                    		}
                                		}
                            		}
                        		}
                            }
                    	}    
                    }
                }
            }
        }*/
    }
    
    
    public static void countryJSONGenerator(String CountryName){
        List<Country__c> countries = [Select Name,Total_Number_of_Districts__c,Total_Number_of_States__c,Country_Code__c,Country_JSON_Data__c 
                                  From Country__c 
                                  Where Name =:CountryName];
        
        if(countries.size() > 0){
            List<StateWrapper> StateWrapperObjectList = new List<StateWrapper>();
            for(String state : mapOfCountryWithStateAndDistrict.get(CountryName).keySet()){
                StateWrapper StateWrapperObject = new StateWrapper();
            	StateWrapperObject.StateName = state;
            	List<DistrictWrapper> DistrictWrapperObjectList = new List<DistrictWrapper>();
            	for(String district : mapOfCountryWithStateAndDistrict.get(CountryName).get(state)){
                    DistrictWrapper DistrictWrapperObject = new DistrictWrapper();
                	DistrictWrapperObject.District = district;
                	DistrictWrapperObjectList.add(DistrictWrapperObject);
            	}
            	StateWrapperObject.Districts = DistrictWrapperObjectList;
            	StateWrapperObjectList.add(StateWrapperObject);
            
        	}
            
            CountryWrapper CountryWrapperObject = new CountryWrapper();
        	CountryWrapperObject.CountryName = countries[0].Name;
        	CountryWrapperObject.CountryCode = countries[0].Country_Code__c;
        	CountryWrapperObject.TotalStates = (Integer)countries[0].Total_Number_of_States__c;
        	CountryWrapperObject.TotalDistricts = (Integer)countries[0].Total_Number_of_Districts__c;
        	CountryWrapperObject.State = StateWrapperObjectList;
            
            System.debug(CountryWrapperObject);
            System.debug(JSON.serialize(CountryWrapperObject));
            countries[0].Country_JSON_Data__c = JSON.serialize(CountryWrapperObject);
            update countries[0];
            
        }
    }
    
    
   
    public class CountryWrapper{
        public String CountryName;
        public String CountryCode;
        public Integer TotalStates;
        public Integer TotalDistricts;
        Public List<StateWrapper> State;
    }
    public class DistrictWrapper{
        public String District;
    }
    public class StateWrapper{
        public String StateName;
        public List<DistrictWrapper> Districts;
    }
}