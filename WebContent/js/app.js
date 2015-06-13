
//devaitorApp namespace
var deviatorApp =  angular.module("deviator-school-app",["ngRoute"]);
deviatorApp.config(["$routeProvider",function(rP){
	rP.when("/",{
		"templateUrl":"html/loading.html",
		"controller":"loadingController"
	}).when("/generateTimetable",{
	"templateUrl":"html/generate_timetable.html",
		"controller":"generateTimeTable"
		})
		.when("/viewTimetable",{
	"templateUrl":"html/view_timetable.html",
		"controller":"viewTimeTable"
		})
	.otherwise({
		"templateUrl":"html/default.html",
		"controller":"defaultController"
	})
	

}]);






deviatorApp.service("appMenuLabel",function()
{
	this.appSection ={
		"ADD_TEACHER":"/addTeacher",
		"MAP_TEACHER":"/mapTeacher",
		"GENERATE_TT":"/generateTimetable",
		"VIEW_TT":"/viewTimetable",
		"FETCH_TEACHER":"fetch-teacher",
		"FETCH_MASTER_DATA":"fetch-master-data"
	};
	
	this.SERVER_URL = {
			"VIEW_TT_LOAD_META_DATA":"fetchSchoolMetaData",
			"LOAD_CLASS_SPECIFIC_DATA":"GetTimeTableOfClass",
			"FETCH_ONLY_TEACHER":"teacherAPI",
			"ADD_NEW_TEACHER":"teacherAPI",
			"DELETE_TEACHER":"deleteTeacher",
			"LOAD_DATA_FOR_MAPPING_SCREEN":"mapCST",
			"DELETE_CST_MAPPING":"deleteCST",
			"FETCH_EXISTING_TT":"fetchTT",
			"SUBMIT_GENERATED_TT":"SubmitGeneratedTimeTable"
	};
	
	
	this.SERVER_URL_1 ={
			"VIEW_TT_LOAD_META_DATA":'data/tt_meta_data.json',
			"LOAD_CLASS_SPECIFIC_DATA":	'data/class_tt.json',
			"FETCH_ONLY_TEACHER":'data/teacher_list.json',
			"ADD_NEW_TEACHER":"data/new_teacher_added.json",
			"DELETE_TEACHER":"data/new_teacher_added.json",
			"LOAD_DATA_FOR_MAPPING_SCREEN":"data/cs_mapped.json",
			"DELETE_CST_MAPPING":"data/cs_mapped.json",
			"FETCH_EXISTING_TT":"data/cs_mapped.json",
			"SUBMIT_GENERATED_TT":"data/tt_submitted.json"
	};
	
	
	this.appServerUrl ={
	"MASTER_DATA_URL":"data/master.json"
	}
});



deviatorApp.service("requestData",["$http","appMenuLabel",function(ajax,appMenuLabel)
{

	this.getData =function(cmd,requestDataObject)
	{
		switch(cmd)
		{
			case appMenuLabel.appSection["FETCH_MASTER_DATA"] :
				ajax.get(appMenuLabel.appServerUrl["MASTER_DATA_URL"]).
									  success(function(data, status, headers, config) {
										// this callback will be called asynchronously
										// when the response is available
										console.log(data);
										requestDataObject.onSuccess(data);
									  }).
									  error(function(data, status, headers, config) {
										// called asynchronously if an error occurs
										// or server returns response with an error status.
										console.log(data);
										requestDataObject.onError(data);
									  });
			break;
		}
	}
	
  
  
	this.appSection ={
		"ADD_TEACHER":"/addTeacher"
	};
}]);




