
deviatorApp.controller("timeTableComponent",function($scope,$location,teacherCollection)
{
	$scope.ttc_days = [];
	$scope.ttc_slots = [];
	$scope.ttc_subjects = [];
	$scope.ttc_teachers = [];
	
	$scope.generateActualTimeTable = function(classID)
	{
		// fetch list of days
		$scope.ttc_days = [{"day_id":1,"day_label":"Monday"},{"day_id":2,"day_label":"Tuesday"},{"day_id":3,"day_label":"Wednesday"},{"day_id":4,"day_label":"Thursday"},{"day_id":5,"day_label":"Friday"}];
		
		//fetch list of slots
		$scope.ttc_slots = [
						{
							"slot_id":"1",
							"slot_label":"8-9"
						},
						{
							"slot_id":"2",
							"slot_label":"9-10"
						},
						{
							"slot_id":"3",
							"slot_label":"10-11"
						},
						{
							"slot_id":"4",
							"slot_label":"11-12"
						},
						{
							"slot_id":"5",
							"slot_label":"12-1"
						}
					]; 
					
		//fetch list of subjects
		$scope.ttc_subjects = [
					{
						"subject_id":11,
						"subject_label":"susane",
						"count":3,
						"continous":1
					},
					{
						"subject_id":12,
						"subject_label":"maina",
						"count":34,
						"continous":1
					},
					{
						"subject_id":13,
						"subject_label":"suresh",
						"count":13,
						"continous":0
					},
					{
						"subject_id":14,
						"subject_label":"raina",
						"count":3,
						"continous":1
					},
					{
						"subject_id":15,
						"subject_label":"kuch bhi",
						"count":3,
						"continous":1
					}
			
					]
		//fetch list of teachers
		$scope.ttc_teachers = [
					{
						"teacher_id":17,
						"teacher_name":"aila"
					},
					{
						"teacher_id":18,
						"teacher_name":"chay la"
					},
					{
						"teacher_id":19,
						"teacher_name":"yyeu ka"
					},
					{
						"teacher_id":20,
						"teacher_name":"bhiii"
					},
					{
						"teacher_id":21,
						"teacher_name":"hudd"
					}
			
				];
				
				
		
		
	}
	
});

// main app controller
deviatorApp.controller("generateTimeTable",function($scope,$location,teacherCollection)
{
		$scope.currentStep = 0;
		$scope.teacherModalInfo ={};
		$scope.teacherInfo ={};
		
		$scope.setUp = function()
		{
			$scope.currentStep = 0;
			teacherCollection.fetchTeacherFromDB({"responseReceived":$scope.teacherListFetched})
			
		}
		$scope.teacherListFetched = function()
		{
			$scope.currentStep = 1;
			$scope.teacherList = teacherCollection.getTeacherListForView();
		}
	/*
	 STEP 1 : Adding Teacher
	*/

		$scope.newTeacherAdded = function( resp)
		{
			if(!resp)
			{
				console.log("ERROR!")
			}
			
		}	
	$scope.addOrEditNewTeacher = function()
	{
		if(Object.keys($scope.teacherInfo).length == 0)
		{
			// New addition
			teacherCollection.addNewTeacherToDB($scope.teacherModalInfo,{"responseReceived":$scope.newTeacherAdded});
		}
		else
		{
			// Edit
			teacherCollection.updateSingleTeacher($scope.teacherModalInfo);
		}
		
		$(".bs-example-modal-lg").modal('hide')
	};
	
	$scope.editTeacherHandler = function(id)
	{
		$scope.teacherInfo = teacherCollection.getSingleTeacher(id);
		$scope.teacherModalInfo = teacherCollection.getSingleTeacher(id);
		$(".bs-example-modal-lg").modal('show')
		console.log($scope.teacherInfo);
	}
	
	$scope.addNewTeacherToDB = function()
	{
		$scope.teacherInfo ={};
		$scope.teacherModalInfo = {};
		$(".bs-example-modal-lg").modal('show')
	};
	
	$scope.deleteTeacherHandler = function(id)
	{
		teacherCollection.deleteSingleTeacher(id,{"responseReceived":$scope.teacherDeletionHandler});
		
	}
	
	$scope.teacherDeletionHandler= function(result)
	{
		if(!result)
		{
			console.log("Error in deleting the record");
			return false;
		}
		$scope.teacherList = teacherCollection.getTeacherListForView();
	}
	/*
	 STEP 1 : Adding Teacher  END###########################################
	*/
		
		$scope.moveToNextStep = function()
		{
			if($scope.currentStep === 0)
			{
				return false;
			}
			if($scope.currentStep < 4)
			$scope.currentStep++
			
			
		}
		$scope.moveToPreviousStep = function()
		{
			if($scope.currentStep === 0)
			{
				return false;
			}
			if($scope.currentStep > 1)
			$scope.currentStep--
		}
	
});



//mappingTeacherAndStudent
deviatorApp.controller("mappingTeacherAndStudent",function($scope,csMappedCollection,teacherCollection)
{
	// 
	//$scope.csCollection ={};
	$scope.class_list =[];
	$scope.csDisplayList = [];
	$scope.map_cst_msg={
			"MSG":""
	}
	$scope.setUpMapping = function()
	{
		$scope.serverMessage = 1;
		$scope.displayMessage = "Fetching Data from Server...";
		
		csMappedCollection.fetchFromDB({"responseReceived":$scope.classSubjectMappingRcvd})
	}
	
	$scope.classSubjectMappingRcvd = function(result)
	{
		if(!result)
		 {
			console.log("ERRpr from class subject Mapping API")
			return false;
		 }
		 $scope.displayMessage = "";
		 $scope.serverMessage = 2;
		// $scope.csCollection = csMappedCollection.getCSMappedData();
		 $scope.csDisplayList = csMappedCollection.csDisplayData();
	}
	
	$scope.mappingDeleted = function(bResult)
	{
		if(!bReturn)
		{
		 console.log(" Error in DEleting the mapping");
		 return false;
		}
		
		$scope.csDisplayList = csMappedCollection.csDisplayData();
	}
	$scope.deleteMapping = function(mapId)
	{
		csMappedCollection.deleteMapping(mapId,{"responseReceived":$scope.mappingDeleted})
		
	}
	$scope.openMappingModal = function()
	{
		$scope.map_cst_msg['MSG'] ="";
		$scope.subjectList = [];	
		$scope.teacherList =[];
		$scope.dropdownClass ={};
		$scope.class_list = csMappedCollection.getClassList();
		if($scope.dropdownSubject !== undefined)
		{
			$scope.dropdownSubject.count = 0;
			$scope.dropdownSubject.continous = 2;
		}
		
		$(".bs-example-modal-relation").modal('show')
	}
	
	$scope.subjectList = [];	
	$scope.teacherList=[];
	
	$scope.dropdownClassChanged = function()
	{
		$scope.map_cst_msg['MSG'] ="";
		$scope.subjectList = $scope.dropdownClass.subjects;
		$scope.teacherList= teacherCollection.getTeacherListForView();//$scope.dropdownClass.teachers;
	}
	
	
	$scope.saveMapping = function()
	{
		var obj ={
			"class_id":$scope.dropdownClass.class_id,
			"class_label":$scope.dropdownClass.class_label,
			"subject_id":$scope.dropdownSubject.subject_id,
			"subject_label":$scope.dropdownSubject.subject_label,
			"teacher_id":$scope.dropdownTeacher.id,
			"teacher_name":$scope.dropdownTeacher.first_name,
			"count":$scope.dropdownSubject.count,
			"continous":$scope.dropdownSubject.continous
		}
		csMappedCollection.addNewMappingToDB(obj,{"responseReceived":$scope.mappingSuccessFul})
	}
	
	$scope.mappingSuccessFul = function(bResult,msg)
	{
		if(bResult && msg === undefined)
		{
			$(".bs-example-modal-relation").modal('hide')
		}
		else
		{
			$scope.map_cst_msg['MSG'] = msg;
		}
			
		
	}
});