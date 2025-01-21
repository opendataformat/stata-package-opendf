*test opendf read



***************Test 1 opendf read: read dataset without any options ********************
program define test_opendf_read_and_write
	local verbose = 1
	****************Test1 : read and write data.zip *******************
	quietly {
		local error_occured1="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		
		local test_dir "`c(pwd)'"
		local testdata_dir "`c(pwd)'\Datasets Testscripts"
		local output_dir "`c(pwd)'\Output Testscripts"

		// Read CSV as text
		// Unzip file first
		// Specify the path to the zip file and the destination folder
		local zipfile "`testdata_dir'\data.zip"
		cd "`output_dir'"
		unzipfile "`zipfile'"
		cd "`test_dir'"
		// Define location of extracted data.csv
		local filepath "`output_dir'\data.csv"  // Replace with the path to your CSV file
		confirm file "`filepath'"
		// Open the file for reading
		tempname fh
		file open `fh' using "`filepath'", read text
		// Read the entire file into a single string
		file read `fh' line
		*local original_csv = `"`macval(line)'"'
		local original_csv = ""
		while r(eof)==0 {
			local linenum = `linenum' + 1
			*display %4.0f `linenum' _asis `"  `macval(line)'"'
			file read `fh' line
			local out = `"`original_csv'\n`macval(line)'"'
		}
		file close `fh'
		
		
		// Define location of extracted metadata.xml
		local filepath "`output_dir'\metadata.xml"  // Replace with the path to your CSV file
		confirm file "`filepath'"
		// Open the file for reading
		tempname fh
		file open `fh' using "`filepath'", read text
		// Read the entire file into a single string
		file read `fh' line
		while r(eof)==0 {
			local original_xml_linenum = `original_xml_linenum' + 1
			*noisily display %4.0f `original_xml_linenum' _asis `"  `macval(line)'"'
			file read `fh' line
			local original_xml_line`original_xml_linenum' = `"`macval(line)'"'
		}
		file close `fh'
		
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		
		
		// Read and Write data.zip and read CSV from opendf write output as text
		// to check for any changes
		opendf read "`testdata_dir'/data.zip", clear
		capture confirm file "$output_folder\testdata"
		if (_rc != 601){
			noisily: di as error "Error in Test 1 opendf read: Zip-File created."
			local error_occured1="TRUE"
		}
		opendf write "Output Testscripts\data.zip", clear

		local zipfile "`output_dir'\data.zip"
		cd "`output_dir'"
		unzipfile "`zipfile'"
		cd "`test_dir'"
		
		// Define location of extracted data.csv
		local filepath "`output_dir'/data.csv"  // Replace with the path to your CSV file
		// Open the file for reading
		tempname fh2
		file open `fh2' using "`filepath'", read text
		// Read the entire file into a single string
		file read `fh2' line
		*local new_csv = `"`macval(line)'"'
		local new_csv = ""
		while r(eof)==0 {
			local linenum = `linenum' + 1
			*display %4.0f `linenum' _asis `"  `macval(line)'"'
			file read `fh2' line
			local out = `"`new_csv'\n`macval(line)'"'
		}
		file close `fh2'
		
		// Define location of extracted metadata.xml
		local filepath "`output_dir'/metadata.xml"  // Replace with the path to your CSV file
		// Open the file for reading
		tempname fh2
		file open `fh2' using "`filepath'", read text
		// Read the entire file into a single string
		file read `fh2' line
		while r(eof)==0 {
			local new_xml_linenum = `new_xml_linenum' + 1
			*noisily display %4.0f `new_xml_linenum' _asis `"  `macval(line)'"'
			file read `fh2' line
			local new_xml_line`new_xml_linenum' = `"`macval(line)'"'
		}
		file close `fh2'
		
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		
		
		
		if(`"`original_csv'"'!=`"`new_csv'"'){
			noisily: di as error "Error in Test 1 opendf read and write: CSV files are not equal after reading and writing with opendf read and opendf write with data.zip."
			local error_occured1="TRUE"
		}
		forvalues line = 3/`original_xml_linenum'{
			if ( subinstr(`"`original_xml_line`line''"', " ", "", .) != subinstr(`"`new_xml_line`line''"', " ", "", .)){
				local error_occured1="TRUE"
				noisily: di as error "Error in Test 1 opendf read and write: XML files are not equal in line `line' after reading and writing with opendf read and opendf write with data_special_values.zip."
				if $verbose == 1 {
					no di "Original line (`line'): "
					no di `"`original_xml_line`line''"'
					no di "New line (`line'): "
					no di `"`new_xml_line`line''"'
				}
			}
		}
	}
	
	
	****************Test2 : read and write data_special_values.zip *******************
	quietly {
		local error_occured2="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		
		local test_dir "`c(pwd)'"
		local testdata_dir "`c(pwd)'\Datasets Testscripts"
		local output_dir "`c(pwd)'\Output Testscripts"

		// Read CSV as text
		// Unzip file first
		// Specify the path to the zip file and the destination folder
		local zipfile "`testdata_dir'\data_special_values.zip"
		cd "`output_dir'"
		unzipfile "`zipfile'"
		cd "`test_dir'"
		// Define location of extracted data.csv
		local filepath "`output_dir'\data.csv"  // Replace with the path to your CSV file
		di "`filepath'"
		confirm file "`filepath'"
		// Open the file for reading
		tempname fh
		file open `fh' using "`filepath'", read text
		// Read the entire file into a single string
		file read `fh' line
		local original_csv = `"`macval(line)'"'
		while r(eof)==0 {
			local linenum = `linenum' + 1
			*display %4.0f `linenum' _asis `"  `macval(line)'"'
			file read `fh' line
			local out = `"`original_csv'\n`macval(line)'"'
		}
		file close `fh'
		
		// Define location of extracted metadata.xml
		local filepath "`output_dir'\metadata.xml"  // Replace with the path to your CSV file
		confirm file "`filepath'"
		// Open the file for reading
		tempname fh
		file open `fh' using "`filepath'", read text
		// Read the entire file into a single string
		file read `fh' line
		local original_xml_linenum = 0
		while r(eof)==0 {
			local original_xml_linenum = `original_xml_linenum' + 1
			*noisily display %4.0f `original_xml_linenum' _asis `"  `macval(line)'"'
			file read `fh' line
			local original_xml_line`original_xml_linenum' = `"`macval(line)'"'
		}
		file close `fh'
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		
		
		// Read and Write data.zip and read CSV from opendf write output as text
		// to check for any changes
		opendf read "`testdata_dir'/data_special_values.zip", clear
		capture confirm file "$output_folder\testdata"
		if (_rc != 601){
			noisily: di as error "Error in Test 2 opendf read: Zip-File created."
			local error_occured2="TRUE"
		}
		opendf write "Output Testscripts\data.zip", clear

		local zipfile "`output_dir'\data.zip"
		cd "`output_dir'"
		unzipfile "`zipfile'"
		cd "`test_dir'"
		// Define location of extracted data.csv
		local filepath "`output_dir'/data.csv"  // Replace with the path to your CSV file
		// Open the file for reading
		tempname fh2
		file open `fh2' using "`filepath'", read text
		// Read the entire file into a single string
		file read `fh2' line
		local new_csv = `"`macval(line)'"'
		while r(eof)==0 {
			local linenum = `linenum' + 1
			*display %4.0f `linenum' _asis `"  `macval(line)'"'
			file read `fh2' line
			local out = `"`new_csv'\n`macval(line)'"'
		}
		file close `fh2'
		
		// Define location of extracted metadata.xml
		local filepath "`output_dir'/metadata.xml"  // Replace with the path to your CSV file
		// Open the file for reading
		tempname fh2
		file open `fh2' using "`filepath'", read text
		// Read the entire file into a single string
		file read `fh2' line
		local new_xml_linenum = 0
		while r(eof)==0 {
			local new_xml_linenum = `new_xml_linenum' + 1
			*noisily display %4.0f `new_xml_linenum' _asis `"  `macval(line)'"'
			file read `fh2' line
			local new_xml_line`new_xml_linenum' = `"`macval(line)'"'
		}
		file close `fh2'
		
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
				

		if(`"`original_csv'"'!=`"`new_csv'"'){
			noisily: di as error "Error in Test 2 opendf read and write: CSV files are not equal after reading and writing with opendf read and opendf write with data_special_values.zip."
			local error_occured2="TRUE"
		}
		forvalues line = 3/`original_xml_linenum'{
			if ( subinstr(`"`original_xml_line`line''"', " ", "", .) != subinstr(`"`new_xml_line`line''"', " ", "", .)){
				local error_occured2="TRUE"
				noisily: di as error "Error in Test 2 opendf read and write: XML files are not equal in line `line' after reading and writing with opendf read and opendf write with data_special_values.zip."
				if $verbose == 1 {
					no di "Original line (`line'): "
					no di `"`original_xml_line`line''"'
					no di "New line (`line'): "
					no di `"`new_xml_line`line''"'
				}
			}
		}
	}
	
	if("`error_occured1'" =="FALSE" & "`error_occured2'" =="FALSE"){
		di "Test opendf read and write successful."
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
	}
end


if (strtrim("	test") == strtrim("test")){
	di "T"
}