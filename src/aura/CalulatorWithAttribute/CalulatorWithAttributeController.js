({
	handleAddition : function(component, event, helper) {
        let firstNumber = component.get("v.fNum");
        let SecondNumber = component.get("v.sNum");
        //let additionResult = component.find("result");
        component.set("v.result",parseInt(firstNumber) + parseInt(SecondNumber));
		//additionResult.set("v.value", parseInt(firstNumber) + parseInt(SecondNumber));
	},
    
    handleAdditionWithApexController: function(component, event, helper) {
    	let firstNumber = component.get("v.fNum");
    	let SecondNumber = component.get("v.sNum");
        let action = component.get("c.calculateTheSum");
        action.setParams({"fNumber":firstNumber,"sNumber":SecondNumber});
        action.setCallback(this,function(responce){
            let state = responce.getState();
            let responceValue = responce.getReturnValue();
            if(state === 'SUCCESS'){
                component.set("v.result",responce.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    
	}
    
})