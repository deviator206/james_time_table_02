
deviatorApp.controller("finalStepTimeTable",function($scope,timetableCollection,csMappedCollection,timetableService)
{
	$scope.ttc_days = [];
	$scope.ttc_slots = [];
	$scope.ttc_subjects = [];
	$scope.ttc_teachers = [];
	$scope.enableClick =false;
	$scope.ttc_timetable;
	$scope.initializeFetchAllData = function()
	{
		$scope.enableClick = false;
		$scope.timetableGenerated = false;
		$scope.ttc_message =" Loading Server Data..."
		timetableService.fetchFromDB({"responseReceived":$scope.ttcLoaded});
	};
	$scope.ttcLoaded = function()
	{
		$scope.enableClick = true;
		$scope.ttc_message =""
	};
	
	
	$scope.submitGeneratedTimeTable =  function()
	{
		timetableService.submitGeneratedTimetable({"responseReceived":$scope.timetableSubmissionSuccess});
	}
	
	$scope.timetableSubmissionSuccess = function()
	{
		console.log(" Submission done");
		
		$scope.ttc_message ="Time Table is successfully submitted";
		
	}
	
	$scope.generateTimeTableFunction = function()
	{
		$scope.timetableGenerated = false;
		$scope.ttc_message ="Please wait Generating fresh Timetable....";
		var classes = timetableCollection.getOnlyClassLabels();
		var slots = timetableCollection.getTTMetaSlots();
		$scope.ttc_slots = slots;
		var days = timetableCollection.getTTMetaDays();
		var timetable ={};
		
		
		for(var classIndex =0;classIndex < classes.length;classIndex++)
		{
				var classRelatedInfo = angular.copy(csMappedCollection.getClassDetails(classes[classIndex].class_id)) ;
				
				
				if(classRelatedInfo !== null)
				{
					var subjects = classRelatedInfo.subjects;
					
					/*subjects.push({
						"subject_id":-99,
						"subject_label":"Break",
						"count" : 1
					})*/
					var slotTracker =[] ,dayTracker =[];
					                  
					for(var subjectIndex =0;subjectIndex < subjects.length;subjectIndex++)
					{
						dayTracker =[];
						for(var subCountIndex = 0; subCountIndex < subjects[subjectIndex].count;subCountIndex++)
						{
							var perDayMax = 1;
							if(subjects[subjectIndex].count > days.length)
								perDayMax = 2;
							
							for(var dayIndex = 0;dayIndex< days.length;dayIndex++)
							{
								var shdExitDay = false;
								if(dayTracker.indexOf(days[dayIndex].day_id) === -1)
								{
									slotTracker =[];
									for(var slotIndex = 0;slotIndex< slots.length;slotIndex++)
									{
										//check for lunch break
										/*if(subjects[subjectIndex].subject_id == -99 && slots[slotIndex].slot_id == 20 )
										{
											var tempObj = {
													"day_id":days[dayIndex].day_id,
													"day_label":days[dayIndex].day_label,
													
													"slot_id":slots[slotIndex].slot_id,
													"class_label":classes[classIndex].class_label,
													"class_id":classes[classIndex].class_id,
													
													"teacher_id" :-11,
													"teacher_name":"",
													
													"subject_id" :-11,
													"subject_label" :"BREAK"
												}; 
											timetableService.addForDisplay(tempObj);
											break;
										
										}
										else
										{*/
										if(slots[slotIndex].slot_id !== 20)
										{
												if(slotTracker.indexOf(slots[slotIndex].slot_id) === -1 && (timetable[classes[classIndex].class_id+"_"+days[dayIndex].day_id+"_"+slots[slotIndex].slot_id] == undefined))
												{
													var teachers = csMappedCollection.getTeachersForSubject(subjects[subjectIndex].subject_id,classes[classIndex].class_id);
													if(teachers !== null && !timetableService.isTeacherBlocked(teachers.teacher_id,classes[classIndex].class_id,days[dayIndex].day_id,slots[slotIndex].slot_id))
													{
														slotTracker.push(slots[slotIndex].slot_id);
														dayTracker.push(days[dayIndex].day_id);
														
														if(slotTracker.length >= perDayMax)
															shdExitDay =true;
														
														var tempObj = {
																"day_id":days[dayIndex].day_id,
																"day_label":days[dayIndex].day_label,
																
																"slot_id":slots[slotIndex].slot_id,
																"slot_label":slots[slotIndex].slot_label,
																"class_label":classes[classIndex].class_label,
																"class_id":classes[classIndex].class_id,
																
																"teacher_id" :teachers.teacher_id,
																"teacher_name":teachers.teacher_name,
																
																"subject_id" :subjects[subjectIndex].subject_id,
																"subject_label" :subjects[subjectIndex].subject_label
															}; 
														timetableService.addRowInTimeTable(tempObj);
														timetableService.addForDisplay(tempObj);
														timetableService.blockTeacher(teachers.teacher_id,classes[classIndex].class_id,days[dayIndex].day_id,slots[slotIndex].slot_id);
														/*timetableService.addBreakInTT({
																"day_id":days[dayIndex].day_id,
																"day_label":days[dayIndex].day_label,
																
																"slot_id":20,
																"class_label":classes[classIndex].class_label,
																"class_id":classes[classIndex].class_id,
																
																"teacher_id" :"34",
																"teacher_name":"BREAK",
																
																"subject_id" :"75",
																"subject_label" :"BREAK"
															});*/
														timetable[classes[classIndex].class_id+"_"+days[dayIndex].day_id+"_"+slots[slotIndex].slot_id]= tempObj;
														if(slotTracker.length >= perDayMax)
															break;
													}
													else
													{
														//rest the current count
														var tempObj = {
																"day_id":days[dayIndex].day_id,
																"day_label":days[dayIndex].day_label,
																"slot_label":slots[slotIndex].slot_label,
																"slot_id":slots[slotIndex].slot_id,
																"class_id":classes[classIndex].class_id,
																"class_label":classes[classIndex].class_label,
																
																"teacher_id" :-1,
																"teacher_name":"NA",
																
																"subject_id" :-1,
																"subject_label" :"NOT AVAILABLE"
															}; 
														timetableService.addForDisplay(tempObj);
														//console.log(" SLOT : "+slots[slotIndex].slot_id +" | "+slots[slotIndex].slot_label+"teachers not availble",teachers)
														
													}//
												}//IF SLOT EXIsT
												
										} //THIS IS REGARDING TO LUNCH
										
										
										
									}//SLOT LOOP
								}//IF DAY DOES  EXIST
								
								if(shdExitDay)
									break;
							}//DAY LOOP
							
							
							
						}//COUNT LOOP
						
					}//SUBJECT LOOP
					
				}// CLASS EXIST
				
			//	console.log(timetable);
		}//CLASS 
		
		for(var classIndex =0;classIndex < classes.length;classIndex++)
			{
				//days
				for(var dayIndex = 0;dayIndex< days.length;dayIndex++)
					{
						timetableService.addBreakInTT({
							"day_id":days[dayIndex].day_id,
							"day_label":days[dayIndex].day_label,
							
							"slot_id":20,
							"class_label":classes[classIndex].class_label,
							"class_id":classes[classIndex].class_id,
							
							"teacher_id" :"34",
							"teacher_name":"BREAK",
							
							"subject_id" :"75",
							"subject_label" :"BREAK"
						});
					}
			}
		console.log(timetableService.getFinalTTObject());
		console.log(timetableService.getFinalTT());
		$scope.ttc_timetable = timetableService.getFinalTTObject();
		$scope.ttc_message ="Time Table Ready for review.";
		$scope.timetableGenerated = true;
		
		
	}
	$scope.ttcLoaded_unique = function()
	{
		var classes = timetableCollection.getOnlyClassLabels();
		var slots = timetableCollection.getTTMetaSlots();
		var days = timetableCollection.getTTMetaDays();
		
		
		//var actualReference = csMappedCollection.getClassDetails(classes[0].class_id);
		var classRelatedInfo = angular.copy(csMappedCollection.getClassDetails(classes[0].class_id)) ;
		
		for(var dayIndex = 0;dayIndex< days.length;dayIndex++)
		{
			
			var localSubjectTracker = [];
			for(var slotIndex = 0;slotIndex< slots.length;slotIndex++)
			{
				if(classRelatedInfo !== null)
				{
					var subjects = classRelatedInfo.subjects;
					
					for(var subjectIndex =0;subjectIndex < subjects.length;subjectIndex++)
					{
						if(localSubjectTracker.indexOf(subjects[subjectIndex].subject_id) == -1 && subjects[subjectIndex].count > 0)
						{
							var teachers = csMappedCollection.getTeachersForSubject(subjects[subjectIndex].subject_id,classes[0].class_id);
							if(teachers !== null)
							{
								console.log(" SLOT : "+slots[slotIndex].slot_id +" | "+slots[slotIndex].slot_label+" SUB :"+subjects[subjectIndex].subject_label +" | "+teachers.teacher_id +" :: "+teachers.teacher_name)
								timetableService.addRowInTimeTable({
									"day_id":days[dayIndex].day_id,
									"day_label":days[dayIndex].day_label,
									
									"slot_id":slots[slotIndex].slot_id,
									"class_id":classes[0].class_id,
									
									"teacher_id" :teachers.teacher_id,
									"teacher_name":teachers.teacher_name,
									
									"subject_id" :subjects[subjectIndex].subject_id,
									"subject_label" :subjects[subjectIndex].subject_label
								});
								subjects[subjectIndex].count--;
								localSubjectTracker.push(subjects[subjectIndex].subject_id);
								break;
							}
							else
							{
								//rest the current count
									console.log(" SLOT : "+slots[slotIndex].slot_id +" | "+slots[slotIndex].slot_label+"teachers not availble",teachers)
							}
							//reduce the 
							
						}
						else
						{
							console.log(" SLOT : "+slots[slotIndex].slot_id +" | "+slots[slotIndex].slot_label+"subjects not available!! due to count funda")
							
						}
					}//subjects Loop
					
				}
			}//slots loop	
			
			if(localSubjectTracker.length < slots.length)
			{
				 // more subjects to be added
			}
			
		}//days loop
		
		console.log(timetableService.getFinalTT());
		
	};
	
	
	/*$scope.generateActualTimeTable = function(classID)
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
						"subject_label":"kuch bhi1",
						"count":3,
						"continous":1
					},
					{
						"subject_id":16,
						"subject_label":"kuch bhi2",
						"count":3,
						"continous":1
					},
					{
						"subject_id":17,
						"subject_label":"kuch bhi3",
						"count":3,
						"continous":1
					},
					{
						"subject_id":18,
						"subject_label":"kuch bhi4",
						"count":3,
						"continous":1
					},
					{
						"subject_id":19,
						"subject_label":"kuch bhi5",
						"count":3,
						"continous":1
					},
					{
						"subject_id":20,
						"subject_label":"kuch bhi6",
						"count":3,
						"continous":1
					},
					{
						"subject_id":21,
						"subject_label":"kuch bhi7",
						"count":3,
						"continous":1
					},
					{
						"subject_id":22,
						"subject_label":"kuch bhi8",
						"count":3,
						"continous":1
					},
					{
						"subject_id":23,
						"subject_label":"kuch bhi9",
						"count":3,
						"continous":1
					},
					{
						"subject_id":24,
						"subject_label":"kuch bhi10",
						"count":3,
						"continous":1
					},
					{
						"subject_id":25,
						"subject_label":"kuch bhi11",
						"count":3,
						"continous":1
					},
					{
						"subject_id":26,
						"subject_label":"kuch bhi12",
						"count":3,
						"continous":1
					},
					{
						"subject_id":27,
						"subject_label":"kuch bhi13",
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
		
		$scope.ttc_mapping =[
		                     	{"subject_id":"11","class_id":"1","teacher_id":"21"},
		                     	{"subject_id":"12","class_id":"1","teacher_id":"18"},
		                     	{"subject_id":"13","class_id":"1","teacher_id":"18"},
		                     	{"subject_id":"14","class_id":"1","teacher_id":"19"},
		                     	{"subject_id":"15","class_id":"1","teacher_id":"20"},
		                     	{"subject_id":"11","class_id":"1","teacher_id":"21"},
		                     	{"subject_id":"15","class_id":"1","teacher_id":"19"},
		                     	{"subject_id":"15","class_id":"1","teacher_id":"21"},
		                     	{"subject_id":"15","class_id":"2","teacher_id":"21"},
		                     	{"subject_id":"15","class_id":"2","teacher_id":"21"}];
		
		
		
				
				
		
		
	}*/
	
});

// main app controller
deviatorApp.controller("generateTimeTable",function($scope,$location,teacherCollection)
{
		$scope.currentStep = 0;
		$scope.teacherModalInfo ={};
		$scope.teacherInfo ={};
		$scope.TOTAL_STEPS = 3;
		
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
			if($scope.currentStep < $scope.TOTAL_STEPS)
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

