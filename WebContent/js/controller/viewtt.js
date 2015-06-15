
// main app controller
deviatorApp.controller("viewTimeTable",function($scope,$location,appMenuLabel,timetableCollection)
{
	$scope.initScreen = function()
	{
		$scope.slotList=[];
		$scope.daysList=[];
		$scope.classList =[];
		$scope.tt = [];
		$scope.ttc_message ="";
		$scope.ttc_message ="fetching meta data from server";
		timetableCollection.loadMetaData({"renderView" : $scope.renderView})
		
	}
	
	$scope.printPage = function()
	{
		window.print();
	}
	
	$scope.renderView = function(result)
	{
		
		$scope.ttc_message ="";
		if(!result)
		{
		 $scope.ttc_message ="In in fetching data from server"
		 console.log(" Error In the resp");
		 return false;
		}
		 
		$scope.classList = timetableCollection.getOnlyClassLabels();
		$scope.daysList = timetableCollection.getTTMetaDays();
		$scope.slotList = timetableCollection.getTTMetaSlots();
		
		console.log("rendering view");	
	}
	
	$scope.showTimeTable = function()
	{
		$scope.ttc_message ="Please wait ... Fetching data from server...";
		console.log("fetch new TT"+$scope.sampleModel.class_label +" || "+$scope.sampleModel.class_id);
		timetableCollection.fetchClassTT($scope.sampleModel.class_id,{"dataFetched":$scope.fullTTFetched})
	}
	
	$scope.fullTTFetched = function()
	{
		$scope.ttc_message ="Successfully fetched the data";
		$scope.tt = timetableCollection.getTimeTable()
	}
	
	$scope.onNavigationClicked = function(navId)
	{
		switch(navId)
		{
			case "view":
				$location.path(appMenuLabel.appSection["VIEW_TT"]);
			 break;
			case "generate":
				$location.path(appMenuLabel.appSection["GENERATE_TT"]);
			break;
		}
	}
	
});