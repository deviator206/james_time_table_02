

//defaultController

deviatorApp.controller("defaultController",function($scope,$location,appMenuLabel)
{
	$scope.returnToHome = function()
	{
		$location.url(appMenuLabel.appSection["VIEW_TT"]);
	};
	
});