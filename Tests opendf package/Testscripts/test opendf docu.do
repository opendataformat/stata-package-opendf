*test opendf docu

program define test_opendf_docu
	quietly{
		*****************  Test 1 opendf docu  ************
		use "Datasets Testscripts\testdata", clear
		local error_occured1="FALSE"
		label language de
		capture opendf docu
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for the dataset in de."
			local error_occured1="TRUE"
		}

			
		capture opendf docu bap96
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap96 in de."
			local error_occured1="TRUE"
		}
		
		capture opendf docu name
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for name in de."
			local error_occured1="TRUE"
		}
		
		capture opendf docu bap9001
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap9001 in de."
			local error_occured1="TRUE"
		}
		
		capture opendf docu bap9002
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap9002 in de."
			local error_occured1="TRUE"
		}
		
		capture opendf docu bap9003
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap9003 in de."
			local error_occured1="TRUE"
		}
		
		capture opendf docu bap9201
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap9201 in de."
			local error_occured1="TRUE"
		}
		
		capture opendf docu bap87
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap87 in de."
			local error_occured1="TRUE"
		}
		
		
		label language en
		capture opendf docu
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for the dataset in en."
			local error_occured1="TRUE"
		}

		capture opendf docu bap96
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap96 in en."
			local error_occured1="TRUE"
		}
		
		capture opendf docu name
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for name in en."
			local error_occured1="TRUE"
		}
		
		capture opendf docu bap9001
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap9001 in en."
			local error_occured1="TRUE"
		}
		
		capture opendf docu bap9002
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap9002 in en."
			local error_occured1="TRUE"
		}
		
		capture opendf docu bap9003
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap9003 in en."
			local error_occured1="TRUE"
		}
		
		capture opendf docu bap9201
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap9201 in en."
			local error_occured1="TRUE"
		}
		
		capture opendf docu bap87
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for bap87 in en."
			local error_occured1="TRUE"
		}
	}
	
	label language de
	opendf docu
	opendf docu bap96
	opendf docu name
	opendf docu bap9001
	opendf docu bap9002
	opendf docu bap9003
	opendf docu bap9201
	opendf docu bap87
	
	label language en
	opendf docu
	opendf docu bap96
	opendf docu name
	opendf docu bap9001
	opendf docu bap9002
	opendf docu bap9003
	opendf docu bap9201
	opendf docu bap87
	
			
		*****************  Test 2 opendf docu  ************
	quietly{
		use "Datasets Testscripts\testdata_with_missings", clear
		local error_occured2="FALSE"
		label language de
		capture opendf docu
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for the dataset in de."
			local error_occured2="TRUE"
		}

			
		capture opendf docu bap96
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap96 in de."
			local error_occured2="TRUE"
		}
		
		capture opendf docu name
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for name in de."
			local error_occured2="TRUE"
		}
		
		capture opendf docu bap9001
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap9001 in de."
			local error_occured2="TRUE"
		}
		
		capture opendf docu bap9002
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap9002 in de."
			local error_occured2="TRUE"
		}
		
		capture opendf docu bap9003
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap9003 in de."
			local error_occured2="TRUE"
		}
		
		capture opendf docu bap9201
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap9201 in de."
			local error_occured2="TRUE"
		}
		
		capture opendf docu bap87
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap87 in de."
			local error_occured2="TRUE"
		}
		
		
		label language en
		capture opendf docu
		if (_rc!=0){
			di as error "Error in Test 1 opendf docu: Opendf docu didn't run successfully for the dataset in en."
			local error_occured2="TRUE"
		}

		capture opendf docu bap96
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap96 in en."
			local error_occured2="TRUE"
		}
		
		capture opendf docu name
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for name in en."
			local error_occured2="TRUE"
		}
		
		capture opendf docu bap9001
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap9001 in en."
			local error_occured2="TRUE"
		}
		
		capture opendf docu bap9002
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap9002 in en."
			local error_occured2="TRUE"
		}
		
		capture opendf docu bap9003
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap9003 in en."
			local error_occured2="TRUE"
		}
		
		capture opendf docu bap9201
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap9201 in en."
			local error_occured2="TRUE"
		}
		
		capture opendf docu bap87
		if (_rc!=0){
			di as error "Error in Test 2 opendf docu: Opendf docu didn't run successfully for bap87 in en."
			local error_occured2="TRUE"
		}
	}
	label language de
	opendf docu
	opendf docu bap96
	opendf docu name
	opendf docu bap9001
	opendf docu bap9002
	opendf docu bap9003
	opendf docu bap9201
	opendf docu bap87
	label language en
	opendf docu
	opendf docu bap96
	opendf docu name
	opendf docu bap9001
	opendf docu bap9002
	opendf docu bap9003
	opendf docu bap9201
	opendf docu bap87
	
	
	
	*****************  Test 3 opendf docu with languages  ************
	quietly{
		use "Datasets Testscripts\testdata", clear
		local error_occured3="FALSE"
		label language de
		capture opendf docu, languages("en")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for the dataset in de."
			local error_occured3="TRUE"
		}

			
		capture opendf docu bap96, languages("en")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap96 in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu name, languages("en")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for name in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9001, languages("en")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9001 in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9002, languages("en")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9002 in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9003, languages("en")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9003 in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9201, languages("en")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9201 in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap87, languages("en")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap87 in de."
			local error_occured3="TRUE"
		}
		
		
		
		capture opendf docu, languages("de")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for the dataset in de."
			local error_occured3="TRUE"
		}

		capture opendf docu bap96, languages("de")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap96 in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu name, languages("de")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for name in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9001, languages("de")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9001 in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9002, languages("de")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9002 in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9003, languages("de")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9003 in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9201, languages("de")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9201 in de."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap87, languages("de")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap87 in de."
			local error_occured3="TRUE"
		}
		
		
		
		capture opendf docu, languages("all")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for the dataset in all."
			local error_occured3="TRUE"
		}

		capture opendf docu bap96, languages("all")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap96 in all."
			local error_occured3="TRUE"
		}
		
		capture opendf docu name, languages("all")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for name in all."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9001, languages("all")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9001 in all."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9002, languages("all")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9002 in all."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9003, languages("all")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9003 in all."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap9201, languages("all")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap9201 in all."
			local error_occured3="TRUE"
		}
		
		capture opendf docu bap87, languages("all")
		if (_rc!=0){
			di as error "Error in Test 3 opendf docu: Opendf docu didn't run successfully for bap87 in all."
			local error_occured3="TRUE"
		}
	}
	
	opendf docu, languages("de")
	opendf docu bap96, languages("de")
	opendf docu name, languages("de")
	opendf docu bap9001, languages("de")
	opendf docu bap9002, languages("de")
	opendf docu bap9003, languages("de")
	opendf docu bap9201, languages("de")
	opendf docu bap87, languages("de")
	
	opendf docu, languages("en")
	opendf docu bap96, languages("en")
	opendf docu name, languages("en")
	opendf docu bap9001, languages("en")
	opendf docu bap9002, languages("en")
	opendf docu bap9003, languages("en")
	opendf docu bap9201, languages("en")
	opendf docu bap87, languages("en")
	
	opendf docu, languages("all")
	opendf docu bap96, languages("all")
	opendf docu name, languages("all")
	opendf docu bap9001, languages("all")
	opendf docu bap9002, languages("all")
	opendf docu bap9003, languages("all")
	opendf docu bap9201, languages("all")
	opendf docu bap87, languages("all")
	
	
	
	if ("`error_occured1'" == "FALSE" & "`error_occured2'" == "FALSE") {
		di "Test opendf docu successful"
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


