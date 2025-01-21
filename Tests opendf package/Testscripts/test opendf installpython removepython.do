*Test opendf installpython and removepython



program define test_opendf_installremovepython
	quietly {
		
		*************** Test 1: opendf installpython with default options
		
		local error_occured1="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		capture opendf installpython
		if (_rc!=0){
			noisily: di as error "Error in Test 1 opendf installpython removepython: opendf installpython didn't run successfully'"
			local error_occured1="TRUE"
		}
		
		local _base_folder=c(sysdir_plus)
		
		capture confirm file "`_base_folder'python3.12\python.exe"
		if (_rc!=0){
			noisily: di as error "Error in Test 1 opendf installpython removepython: python.exe not found"
			local error_occured1="TRUE"
		}
				
		capture set python_exec "`_temp_folder'python3.12\python.exe"
		if (_rc!=7101 & _rc!=0){
			noisily: di as error "Error in Test 1 opendf installpython removepython: Python not initialized successfully"
			local error_occured1="TRUE"
		}
		
				
		*************** Test 2: opendf installpython with other version and remove python versions from base folder
		
		local error_occured2 ="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		capture opendf installpython, version(3.10)
		if (_rc!=0){
			noisily: di as error "Error in Test 2 opendf installpython removepython: opendf installpython didn't run successfully'"
			local error_occured2="TRUE"
		}
		
		capture opendf installpython, version(3.11)
		if (_rc!=0){
			noisily: di as error "Error in Test 2 opendf installpython removepython: opendf installpython didn't run successfully'"
			local error_occured2="TRUE"
		}
		
		local _base_folder=c(sysdir_plus)
		
		capture confirm file "`_base_folder'python3.10\python.exe"
		if (_rc!=0){
			noisily: di as error "Error in Test 2 opendf installpython removepython: python.exe for python 3.10 not found"
			local error_occured2="TRUE"
		}
		capture confirm file "`_base_folder'python3.11\python.exe"
		if (_rc!=0){
			noisily: di as error "Error in Test 2 opendf installpython removepython: python.exe for python 3.11 not found"
			local error_occured2="TRUE"
		}

		opendf removepython, version(3.10)
		capture confirm file "`_base_folder'python3.11\python.exe"
		if (_rc!=0){
			noisily: di as error "Error in Test 2 opendf installpython removepython: python.exe for python 3.11 was deleted when removing python 3.10"
			local error_occured2="TRUE"
		}
		
		capture confirm file "`_base_folder'python3.10\python.exe"
		if (_rc==0){
			noisily: di as error "Error in Test 2 opendf installpython removepython: python.exe for python 3.10 was not removed successfully"
			local error_occured2="TRUE"
		}

		opendf removepython, version(3.11)
		capture confirm file "`_base_folder'python3.10\python.exe"
		if (_rc==0){
			noisily: di as error "Error in Test 2 opendf installpython removepython: python.exe for python 3.10 was not removed successfully"
			local error_occured2="TRUE"
		}
		capture confirm file "`_base_folder'python3.11\python.exe"
		if (_rc==0){
			noisily: di as error "Error in Test 2 opendf installpython removepython: python.exe for python 3.10 was not removed successfully"
			local error_occured2="TRUE"
		}
		
		*************** Test 3: opendf installpython with other version in tempfolder and remove python versions from base folder
		
		local error_occured3="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		local _temp_folder=c(tmpdir)
		capture opendf installpython, version(3.11) location("`_temp_folder'")
		if (_rc!=0){
			noisily: di as error "Error in Test 3  opendf installpython removepython: opendf installpython didn't run successfully'"
			local error_occured3="TRUE"
		}
		
		capture opendf installpython, location("`_temp_folder'")
		if (_rc!=0){
			noisily: di as error "Error in Test 3  opendf installpython removepython: opendf installpython didn't run successfully'"
			local error_occured3="TRUE"
		}
		

		capture confirm file "`_temp_folder'python3.11\python.exe"
		if (_rc!=0){
			noisily: di as error "Error in Test 3  opendf installpython removepython: python.exe for python 3.11 not found"
			local error_occured3="TRUE"
		}
		capture confirm file "`_temp_folder'python3.12\python.exe"
		if (_rc!=0){
			noisily: di as error "Error in Test 3  opendf installpython removepython: python.exe for python 3.11 not found"
			local error_occured3="TRUE"
		}
		
		opendf removepython, location("`_temp_folder'")
		capture confirm file "`_temp_folder'python3.11\python.exe"
		if (_rc==0){
			noisily: di as error "Error in Test 3  opendf installpython removepython: python 3.11 was not removed successfully from tempfolder"
			local error_occured3="TRUE"
		}
		capture confirm file "`_temp_folder'python3.12\python.exe"
		if (_rc==0){
			noisily: di as error "Error in Test 3  opendf installpython removepython: python 3.12 was not removed successfully from tempfolder"
			local error_occured3="TRUE"
		}
		
		
	}
	
	clear 

	if("`error_occured1'" =="FALSE" & "`error_occured2'" =="FALSE" & "`error_occured3'" =="FALSE"){
		di "Test opendf installpython and removepython successful"
	}
	else {
		di "Some tests were not successful"
		if("`error_occured1'" =="FALSE"){
			di "Test 1 Successful"
		}
		else {
			di "Test 1 not successful"
		}

		if("`error_occured2'" =="FALSE"){
			di "Test 2 Successful"
		}
		else {
			di "Test 2 not successful"
		}

		if("`error_occured3'" =="FALSE"){
			di "Test 3 Successful"
		}
		else {
			di "Test 3 not successful"
		}
	}
end