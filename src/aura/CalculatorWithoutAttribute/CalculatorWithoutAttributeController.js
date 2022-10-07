({
	handleAddition : function(component, event, helper) {
        let firstNumber = component.find("fNum").get("v.value");
        let SecondNumber = component.find("sNum").get("v.value");
        let additionResult = component.find("result");
		additionResult.set("v.value", parseInt(firstNumber) + parseInt(SecondNumber));
	}
})