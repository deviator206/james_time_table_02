//deviatorApp


deviatorApp.service("classCollection",function(){
	var classCollection = [];
	this.setClassCollection = function(arrT){
		classCollection = arrT;
	}
	
	
	
});

//class and subject
deviatorApp.service("csMappedCollection",function($http,appMenuLabel){
	var classCollection = [];
	var onlyClassList = [];
	var csDisplay = [];
	this.getClassList = function()
	{
		return onlyClassList;
	};
	this.getTeachersForSubject = function(subjectId,classId)
	{
		var i =0;
		var bReturn = null;
		
		for(i=0;i<csDisplay.length;i++)
		{
			if(csDisplay[i]["class_id"] == classId && csDisplay[i]["subject_id"] == subjectId  )
			{
				bReturn = csDisplay[i];
				break;	
			}
		}
		
		return bReturn;
		
	}
	
	this.getClassDetails = function(classId)
	{
		var i =0;
		var bReturn = null;
		
		for(i=0;i<onlyClassList.length;i++)
		{
			if(onlyClassList[i]["class_id"] == classId)
			{
				bReturn = onlyClassList[i];
				break;	
			}
		}
		
		return bReturn
	};
	this.fetchFromDB = function(controllerInstance)
	{
		if(csDisplay.length <= 0)
		{
		 // fetch from server
	//	 $http.get('data/cs_mapped.json').
			$http.get(appMenuLabel.SERVER_URL['LOAD_DATA_FOR_MAPPING_SCREEN']).
			  success(function(data, status, headers, config) {
				// this callback will be called asynchronously
				// when the response is available
				//classCollection = data.csmap;
				onlyClassList =  data.onlyClass;
				csDisplay = data.cs_view;
				controllerInstance.responseReceived(true);
				
			  }).
			  error(function(data, status, headers, config) {
				// called asynchronously if an error occurs
				// or server returns response with an error status.
				controllerInstance.responseReceived(false);
			  });	
		 
		 
		}
		else
		{
			// use the same 
			controllerInstance.responseReceived(true);
		}
		
	}
	
	this.getCSMappedData = function()
	{
		return  classCollection;
	}
	this.csDisplayData = function()
	{
		return csDisplay;
	}
	this.deleteMapping = function(mapId,controllerInstance)
	{
		
		$http.post(appMenuLabel.SERVER_URL['DELETE_CST_MAPPING'],{"id":mapId}).
		  success(function(data, status, headers, config) {
			  
			  var i =0;
			  
				for(i=0;i<csDisplay.length;i++)
				{
					if(Number(csDisplay[i]["map_id"]) === Number(mapId))
					{
						bReturn = true;
						csDisplay.splice(i,1);
						break;
					}
				}
				controllerInstance.responseReceived(true);
			
		  }).
		  error(function(data, status, headers, config) {
			controllerInstance.responseReceived(false);
		  });	
		
		
		
	}
	
	this.addNewMappingToDB = function(obj,controllerInstance)
	{
			//$http.get('data/cs_mapped_added_new.json').
		$http.post(appMenuLabel.SERVER_URL['LOAD_DATA_FOR_MAPPING_SCREEN'],obj).
			  success(function(data, status, headers, config) {
				// this callback will be called asynchronously
				// when the response is available
				  if(data["alreadyExist"] === undefined )
				  {
					  csDisplay.push(data);
					  controllerInstance.responseReceived(true);
				  }
				  else
				  {
					  controllerInstance.responseReceived(true,data["alreadyExist"]);
				  }
				  
				
			  }).
			  error(function(data, status, headers, config) {
				// called asynchronously if an error occurs
				// or server returns response with an error status.
				controllerInstance.responseReceived(false);
			  });	
	}
	
	
	
});

deviatorApp.service("timetableCollection",function($http,appMenuLabel){
	var ttCollection = {};
	var onlyClasses =[];
	var ttMetaData = {};
	
	
	this.loadMetaData = function(controllerScope)
	{
		if(Object.keys(ttMetaData).length > 0)
		{ //already data exist
			controllerScope.renderView(true);
		}
		else
		{
			//fetch fresh
			$http.get(appMenuLabel.SERVER_URL['VIEW_TT_LOAD_META_DATA']).
			  success(function(data, status, headers, config) {
				// this callback will be called asynchronously
				// when the response is available
					onlyClasses = data.onlyClass;
					ttMetaData = data.onlyMetaData;
					controllerScope.renderView(true);
			  }).
			  error(function(data, status, headers, config) {
				// called asynchronously if an error occurs
				// or server returns response with an error status.
					controllerScope.renderView(false);
			  });
			
		}
		
	};
	
	this.fetchClassTT = function(id,controllerScope)
	{
		$http.get('data/class_tt.json?id='+id).
			  success(function(data, status, headers, config) {
				// this callback will be called asynchronously
				// when the response is available
					ttCollection = data.readOnlyTimeTable;
					controllerScope.dataFetched(true);
			  }).
			  error(function(data, status, headers, config) {
				// called asynchronously if an error occurs
				// or server returns response with an error status.
					controllerScope.dataFetched(false);
			  });
	}
	
	
	
	this.setTTCollection = function(arrT,onlyclass,onlyMetaData){
		ttCollection = arrT;
		onlyClasses = onlyclass;
		ttMetaData = onlyMetaData;
		
	};
	this.getTimeTable= function()
	{
		return ttCollection;
	};
	this.getTTMetaDays = function()
	{
		return ttMetaData.days
	};
	
	this.getTTMetaSlots = function()
	{
		return ttMetaData.slots
	};
	this.getOnlyClassLabels = function()
	{
		return onlyClasses;
	}
	
	
});

deviatorApp.service("timetableService",function($http,appMenuLabel){
	// this would be responsible for TIME TABLE
	var ttc =[];
	var teachersBlocked={};
	var displayPurpose ={};
	this.blockTeacher = function(teacherId,classId,dayId,slotId,subjectId)
	{
		teachersBlocked[teacherId+"#"+classId+"_"+dayId+"_"+slotId]=subjectId;
	};
	this.isTeacherBlocked = function(teacherId,classId,dayId,slotId)
	{
		var bReturn = false;
		
		if(teachersBlocked.hasOwnProperty(teacherId+"#"+classId+"_"+dayId+"_"+slotId))
			bReturn = true;
		
		return bReturn;
	}
	
	this.fetchFromDB = function(instance)
	{
		$http.get(appMenuLabel.SERVER_URL["FETCH_EXISTING_TT"]).
		  success(function(data, status, headers, config) {
			ttc = data.timetable;
			instance.responseReceived(true);
		  }).
		  error(function(data, status, headers, config) {
			instance.responseReceived(false);
		  });
		
	};
	
	this.addRowInTimeTable = function(obj)
	{
		ttc.push(obj);
	};
	
	this.getFinalTT = function()
	{
		return ttc;	
	};
	
	this.addBreakInTT = function()
	{
		
	}
	
	this.addForDisplay = function(value)
	{
		if(displayPurpose.hasOwnProperty(value.class_id))
		{
			 //YES
			if(displayPurpose[value.class_id]["days_list"].hasOwnProperty(value.day_id))
			{//DAY EXIST
				displayPurpose[value.class_id]["days_list"][value.day_id]["slot_list"][value.slot_id] = value;
			}
			else
			{
				 //NEW DAY
				displayPurpose[value.class_id]["days_list"][value.day_id]={};
				displayPurpose[value.class_id]["days_list"][value.day_id] ={
						"day_label":value.day_label,
						"slot_list":{}
				};
				displayPurpose[value.class_id]["days_list"][value.day_id]["slot_list"][value.slot_id] = value;
			}
		}
		else
		{
			// NEW ENTRY
			displayPurpose[value.class_id] ={
					"class_label":value.class_label,
					"days_list":{}
			};
			
			displayPurpose[value.class_id]["days_list"][value.day_id] = {
					"day_label":value.day_label,
					"slot_list":{}
			};
			
			displayPurpose[value.class_id]["days_list"][value.day_id]["slot_list"][value.slot_id] = value; 
			
		}
	};
	
	this.getFinalTTObject = function()
	{
		return displayPurpose;
	};
});

deviatorApp.service("teacherCollection",function($http,appMenuLabel){
	var teacherList = [];
	
	this.setTeacherList = function(arrT)
	{
		teacherList = arrT;
	};
	this.addNewTeacherToDB = function(obj,instance)
	{
		$http.post(appMenuLabel.SERVER_URL["ADD_NEW_TEACHER"], obj).
		//$http.get(appMenuLabel.SERVER_URL["ADD_NEW_TEACHER"]).
			  success(function(data, status, headers, config) {
				// this callback will be called asynchronously
				// when the response is available
				teacherList.push(data);
				instance.responseReceived(true);
				
			  }).
			  error(function(data, status, headers, config) {
				// called asynchronously if an error occurs
				// or server returns response with an error status.
				instance.responseReceived(false);
			  });
	}
	this.fetchTeacherList = function()
	{
		return teacherList;
	};
	
	this.getTeacherListForView = function(){
		return teacherList;
			
	};
	this.updateSingleTeacher = function(obj)
	{
			var obj = false;
		for(var i = 0;i<teacherList.length;i++)
		{
			if(teacherList[i].id === id)
			{
				obj = true;
				teacherList[i]["first_name"] = obj["first_name"]
				teacherList[i]["last_name"]	= obj["last_name"]		
			 break;
			}
		}
		
		return obj;
	
	};
	
	this.getSingleTeacher = function(id)
	{
		var obj = {};
		for(var i = 0;i<teacherList.length;i++)
		{
			if(teacherList[i].id === id)
			{
			 obj = teacherList[i];	
			 break;
			}
		}
		return obj;
	};
	
	this.deleteSingleTeacher = function(id,controllerInstance)
	{
		var obj = false;
		for(var i = 0;i<teacherList.length;i++)
		{
			if(teacherList[i].id === id)
			{
				 obj= {
				 "id":teacherList[i].id,
				 "index":i
				 }
				 //teacherList.splice(i,1);
				 break;
			}
		}
		
		
		$http.post(appMenuLabel.SERVER_URL["DELETE_TEACHER"], obj).
			  success(function(data, status, headers, config) {
				teacherList.splice(obj["index"],1);
				controllerInstance.responseReceived(true);
				
			  }).
			  error(function(data, status, headers, config) {
				  controllerInstance.responseReceived(false);
			  });
		
		
	};
	
	this.fetchTeacherFromDB = function(instance)
	{
		if(teacherList.length > 0 )
		{
			instance.responseReceived(true);
		}
		else
		{
			$http.get(appMenuLabel.SERVER_URL["FETCH_ONLY_TEACHER"]).
			  success(function(data, status, headers, config) {
				// this callback will be called asynchronously
				// when the response is available
				teacherList = data.teachers;
				instance.responseReceived(true);
			  }).
			  error(function(data, status, headers, config) {
				// called asynchronously if an error occurs
				// or server returns response with an error status.
				instance.responseReceived(false);
			  });
		}
			
	}	
	this.addNewTecherFromView = function(info)
	{
	
	};
	
	this.deleteTeacherFromView = function(info)
	{
	
	};

});

deviatorApp.service("masterAppData",function(classCollection,teacherCollection,appBootstrap,timetableCollection){
	var appMaster ={};
	
	this.setMaster= function(data)
	{
		teacherCollection.setTeacherList(data.teachers);
		classCollection.setClassCollection(data.classAndSubject)
		timetableCollection.setTTCollection(data.readOnlyTimeTable,data.onlyClass,data.onlyMetaData)
		appBootstrap.setMasterLoaded(true);
	};

});



deviatorApp.service("appBootstrap",function(classCollection,teacherCollection,$location)
{
	var  masterDataLoaded = false;
	this.setMasterLoaded = function(val)
	{
		masterDataLoaded = val;
	}
	
	this.loadBaseData = function(controllerInstance){
	
		
	}
	this.isMasterLoaded = function( controllerInstance )
	{
	
		
		if(masterDataLoaded)
		{
			controllerInstance.renderView();
		}
		else
		{
			$location.path("/")	
		}
	}
	
});


