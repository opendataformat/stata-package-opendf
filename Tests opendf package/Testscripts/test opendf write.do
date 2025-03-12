*test opendf write




program define test_opendf_write
	quietly {
		
		*****************  Test 1 opendf write: opendf write with testdata  ************
		use "Datasets Testscripts\testdata", clear
		local error_occured1="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		capture opendf write "$output_folder/testdata_out.zip"

		if (_rc!=0){
			di as error "Error in Test 1 opendf write: Opendf Write didn't run successfully."
			local error_occured1="TRUE"
		}

		capture confirm file "$output_folder/testdata_out.zip"

		if (_rc!=0){
			di as error "Error in Test 1 opendf write: Opendf Write didn't run successfully."
			local error_occured1="TRUE"
		}

		capture opendf write "$output_folder/testdata_out.zip"
		di _rc
		if (_rc != 602) {
			di as error "Error in Test 1 opendf write: Opendf Write didn't return the correct error message when the output file already exists and replace is not indicated.'"
			local error_occured1="TRUE"
		}

		opendf write "$output_folder/testdata_out.zip", replace
		capture opendf write "$output_folder/testdata_out.zip", replace
		if (_rc != 0) {
			di as error "Error in Test 1 opendf write: Opendf Write didn't return the correct error message when the output file already exists and replace is not indicated.'"
			local error_occured1="TRUE"
		}

		*****************  Test 2: opendf write with testdata using input() option  ************
		local error_occured2 "FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"

		use "Datasets Testscripts\testdata_with_default", clear

		opendf write "$output_folder/testdata_out.zip", input(Datasets Testscripts\testdata)
		if (_rc!=0){
			di as error "Error in Test 2: Opendf Write didn't run successfully."
			local error_occured2="TRUE"
		}

		capture confirm file "$output_folder/testdata_out.zip"
		if (_rc!=0){
			di as error "Error in Test 2: Opendf Write didn't run successfully."
			local error_occured2="TRUE"
		}

		opendf read "$output_folder/testdata_out.zip", clear

		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "en de"){
			di as error "Error in Test 2 opendf write: Opendf Write didn't save the languages properly."
			local error_occured2="TRUE"
		}


		if(c(N) != 20 | c(k)!=7) {
			di as error "Error in Test 2 opendf write: Dataset dimensions not correct."
			local error_occured2="TRUE"
		}
		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "en de"){
			di as error "Error in Test 2 opendf write: Languages not correct."
			local error_occured2="TRUE"
		}
		local _url : char _dta[url]
		local _dataset: char _dta[dataset]
		local _description_de: char _dta[description_de]
		local _description_en: char _dta[description_en]
		label language de
		local _label_de: data label
		label language en
		local _label_en: data label

		local _url_correct "https://paneldata.org/soep-core/data/bap"
		local _dataset_correct "bap"
		local _description_de_correct `"Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens „Leben in Deutschland – Befragung 2010 zur sozialen Lage - Personenfragebogen für alle“ erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im Haushalt. Eine Ansicht des Erhebungsinstrumentes finden Sie hier: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"' 
		local _description_en_correct `"The data were collected as part of the SOEP-Core study using the questionnaire "Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all. This questionnaire is addressed to the individual persons in the household. A view of the survey instrument can be found here: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"'
		local _label_de_correct "Daten vom Personenfragebogen 2010"
		local _label_en_correct "Data from individual questionnaires 2010"


		if (`"`_url'"' != `"`_url_correct'"' | `"`_dataset'"' != `"`_dataset_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"') {
			di as error "Error in Test 2 opendf write: Dataset Metadata not correct."
			local error_occured2="TRUE"
		}

		local _url : char bap87[url]
		local _type: char bap9201[type]
		local _description_de: char bap9001[description_de]
		local _description_en: char bap9001[description_en]
		local _description2_de: char bap9002[description_de]
		local _description2_en: char bap9002[description_en]
		local _description3_de: char name[description_de]
		local _description3_en: char name[description_en]
		label language de
		local _label_de:  var label bap9003
		local _label2_de: var label bap96 
		label language en
		local _label_en: var label bap9003 
		local _label2_en: var label bap96 

		*di "`_url'"
		*di "`_type'"
		*di "`_description_de'"
		*di "`_description_en'"
		*di "`_description2_de'"
		*di "`_description2_en'"
		*di "`_description3_de'"
		*di "`_description3_en'"
		*di "`_label_de'"
		*di "`_label_en'"
		*di "`_label2_de'"
		*di "`_label2_en'"
		local _url_correct `"https://paneldata.org/soep-core/data/bap/bap87"'
		local _type_correct `"numeric"'
		local _description_de_correct `"Häufigkeit des Gefühls von Zeitdruck in den letzten 4 Wochen"' 
		local _description_en_correct `"Frequency of feeling time pressure in the past 4 weeks"'
		local _description2_de_correct `"Häufigkeit der Niedergeschlagenheit"' 
		local _description2_en_correct `"Frequency of feeling a sad and depressed state"'
		local _description3_de_correct `"Vorname"' 
		local _description3_en_correct `"Firstname"'
		local _label_de_correct `"Ausgeglichen letzten 4 Wochen"'
		local _label_en_correct `"Well-balanced Last 4 Weeks"'
		local _label2_de_correct `"Körpergröße"'
		local _label2_en_correct `"Height"'

		if (`"`_url'"' != `"`_url_correct'"' | `"`_type'"' != `"`_type_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' |`"`_description2_de'"' != `"`_description2_de_correct'"' | `"`_description2_en'"' != `"`_description2_en_correct'"' |`"`_description3_de'"' != `"`_description3_de_correct'"' | `"`_description3_en'"' != `"`_description3_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"' | `"`_label2_de'"' != `"`_label2_de_correct'"' | `"`_label2_en'"' != `"`_label2_en_correct'"') {
			di as error "Error in Test 2 opendf write: Variable Metadata not correct."
			local error_occured2="TRUE"
		}

		label language en
		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9003[7]
		local _label3= "`:label (bap9003) `_val3''"

		local _val4=bap9002[11]
		local _label4= "`:label (bap9002) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap9001) `_val6''"

		local _val7=name[20]


		*di "`_label1'"
		*di "`_label2'"
		*di "`_label3'"
		*di "`_label4'"
		*di "`_label5'"
		*di "`_label6'"

		*di "`_val1'"
		*di "`_val2'"
		*di "`_val3'"
		*di "`_val4'"
		*di "`_val5'"
		*di "`_val6'"
		*di "`_val7'"


		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton"){
			di as error "Error in Test 2 opendf write: Values not correct."
			local error_occured2="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="No Answer" | "`_label4'"!="Always" | "`_label5'"!="8" | "`_label6'"!="Always"){
			di as error "Error in Test 2 opendf write: Value Labels not correct."
			local error_occured2="TRUE"
		}


		label language de

		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9003[7]
		local _label3= "`:label (bap9003) `_val3''"

		local _val4=bap9002[11]
		local _label4= "`:label (bap9002) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap9001) `_val6''"

		local _val7=name[20]

		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton"){
			di as error "Error in Test 2 opendf write: Values not correct."
			local error_occured2="TRUE"
		}

		if("`_label1'"!="trifft nicht zu" | "`_label2'"!="." | "`_label3'"!="keine Angabe" | "`_label4'"!="Immer" | "`_label5'"!="8" | "`_label6'"!="Immer"){
			di as error "Error in Test 2 opendf write: Value Labels not correct."
			local error_occured2="TRUE"
		}





		*****************  Test 3: opendf write with testdata_with_default_language  ************
		local error_occured3 "FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		clear 

		use "Datasets Testscripts\testdata_with_default.dta"

		capture opendf write "$output_folder/testdata_with_default_language_out.zip"
		if (_rc!=0){
			di as error "Error in Test 3 opendf write: Opendf Write didn't run successfully."
			local error_occured3="TRUE"
		}

		capture confirm file "$output_folder/testdata_with_default_language_out.zip"
		if (_rc!=0){
			di as error "Error in Test 3 opendf write: Opendf Write didn't run successfully."
			local error_occured3="TRUE"
		}

		opendf read "$output_folder/testdata_with_default_language_out.zip", clear

		if(c(N) != 20 | c(k)!=7) {
			di as error "Error in Test 3 opendf write: Dataset dimensions not correct."
			local error_occured3="TRUE"
		}
		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "default en de"){
			di as error "Error in Test 3 opendf write: Languages not correct."
			local error_occured3="TRUE"
		}
		local _url : char _dta[url]
		local _dataset: char _dta[dataset]
		local _description_default: char _dta[description]
		local _description_de: char _dta[description_de]
		local _description_en: char _dta[description_en]
		label language default
		local _label_default: data label
		label language de
		local _label_de: data label
		label language en
		local _label_en: data label

		local _url_correct "https://paneldata.org/soep-core/data/bap"
		local _dataset_correct "bap"
		local _description_de_correct `"Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens „Leben in Deutschland – Befragung 2010 zur sozialen Lage - Personenfragebogen für alle“ erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im Haushalt. Eine Ansicht des Erhebungsinstrumentes finden Sie hier: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"' 
		local _description_en_correct `"The data were collected as part of the SOEP-Core study using the questionnaire "Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all. This questionnaire is addressed to the individual persons in the household. A view of the survey instrument can be found here: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"'
		local _description_default_correct `"The data were collected as part of the SOEP-Core study using the questionnaire "Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all. This questionnaire is addressed to the individual persons in the household. A view of the survey instrument can be found here: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"'
		local _label_de_correct "Daten vom Personenfragebogen 2010"
		local _label_en_correct "Data from individual questionnaires 2010"
		local _label_default_correct "Data from individual questionnaires 2010"

		if (`"`_url'"' != `"`_url_correct'"' | `"`_dataset'"' != `"`_dataset_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' | `"`_description_default'"' != `"`_description_default_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"' | `"`_label_default'"' != `"`_label_default_correct'"' ) {
			di as error "Error in Test 3 opendf write: Dataset Metadata not correct."
			local error_occured3="TRUE"
		}
				
		
		local _url : char bap87[url]
		local _type: char bap9201[type]
		local _description_default: char bap9001[description]
		local _description_de: char bap9001[description_de]
		local _description_en: char bap9001[description_en]
		local _description2_default: char bap9002[description]
		local _description2_de: char bap9002[description_de]
		local _description2_en: char bap9002[description_en]
		local _description3_default: char name[description]
		local _description3_de: char name[description_de]
		local _description3_en: char name[description_en]
		label language default
		local _label_default:  var label bap9003
		local _label2_default: var label bap96 
		label language de
		local _label_de:  var label bap9003
		local _label2_de: var label bap96 
		label language en
		local _label_en: var label bap9003 
		local _label2_en: var label bap96 


		local _url_correct `"https://paneldata.org/soep-core/data/bap/bap87"'
		local _type_correct `"numeric"'
		local _description_default_correct `"Frequency of feeling time pressure in the past 4 weeks"' 
		local _description_de_correct `"Häufigkeit des Gefühls von Zeitdruck in den letzten 4 Wochen"' 
		local _description_en_correct `"Frequency of feeling time pressure in the past 4 weeks"'
		local _description2_default_correct `"Frequency of feeling a sad and depressed state"'
		local _description2_de_correct `"Häufigkeit der Niedergeschlagenheit"' 
		local _description2_en_correct `"Frequency of feeling a sad and depressed state"'
		local _description3_default_correct `"Firstname"'
		local _description3_de_correct `"Vorname"' 
		local _description3_en_correct `"Firstname"'
		local _label_default_correct `"Well-balanced Last 4 Weeks"'
		local _label_de_correct `"Ausgeglichen letzten 4 Wochen"'
		local _label_en_correct `"Well-balanced Last 4 Weeks"'
		local _label2_default_correct `"Height"'
		local _label2_de_correct `"Körpergröße"'
		local _label2_en_correct `"Height"'

		if (`"`_url'"' != `"`_url_correct'"' | `"`_type'"' != `"`_type_correct'"' | `"`_description_default'"' != `"`_description_default_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' | `"`_description2_default'"' != `"`_description2_default_correct'"'|`"`_description2_de'"' != `"`_description2_de_correct'"' | `"`_description2_en'"' != `"`_description2_en_correct'"'| `"`_description3_default'"' != `"`_description3_default_correct'"' |`"`_description3_de'"' != `"`_description3_de_correct'"' | `"`_description3_en'"' != `"`_description3_en_correct'"' | `"`_label_default'"' != `"`_label_default_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"' | `"`_label2_default'"' != `"`_label2_default_correct'"'  | `"`_label2_de'"' != `"`_label2_de_correct'"' | `"`_label2_en'"' != `"`_label2_en_correct'"') {
			di as error "Error in Test 3 opendf write: Variable Metadata not correct."
			local error_occured3="TRUE"
		}
		label language en

		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9003[7]
		local _label3= "`:label (bap9003) `_val3''"

		local _val4=bap9002[11]
		local _label4= "`:label (bap9002) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap9001) `_val6''"

		local _val7=name[20]

		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton"){
			di as error "Error in Test 3 opendf write: Values not correct."
			local error_occured3="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="No Answer" | "`_label4'"!="Always" | "`_label5'"!="8" | "`_label6'"!="Always"){
			di as error "Error in Test 3 opendf write: Value Labels not correct."
			local error_occured3="TRUE"
		}

		label language default

		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9003[7]
		local _label3= "`:label (bap9003) `_val3''"

		local _val4=bap9002[11]
		local _label4= "`:label (bap9002) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap9001) `_val6''"

		local _val7=name[20]

		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton"){
			di as error "Error in Test 3 opendf write: Values not correct."
			local error_occured3="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="No Answer" | "`_label4'"!="Always" | "`_label5'"!="8" | "`_label6'"!="Always"){
			di as error "Error in Test 3 opendf write: Value Labels not correct."
			local error_occured3="TRUE"
		}

		label language de

		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9003[7]
		local _label3= "`:label (bap9003) `_val3''"

		local _val4=bap9002[11]
		local _label4= "`:label (bap9002) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap9001) `_val6''"

		local _val7=name[20]


		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton"){
			di as error "Error in Test 3 opendf write: Values not correct."
			local error_occured3="TRUE"
		}

		if("`_label1'"!="trifft nicht zu" | "`_label2'"!="." | "`_label3'"!="keine Angabe" | "`_label4'"!="Immer" | "`_label5'"!="8" | "`_label6'"!="Immer"){
			di as error "Error in Test 3 opendf write: Value Labels not correct."
			local error_occured3="TRUE"
		}





		********************  Test 4 opendf write: write dataset with missings and special characters *******************

		local error_occured4="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"

		use "Datasets Testscripts\testdata_with_missings", clear
		capture opendf write "$output_folder/testdata with missings out.zip"
		if (_rc != 0){
			di as error "Error in Test 4: Error writting the dataset"
		}

		capture confirm file "$output_folder/testdata with missings out.zip"
		if (_rc != 0){
			di as error "Error in Test 4: Error in writting the .zip. Zip-File not in the folder."
		}


		capture opendf read "$output_folder/testdata with missings out.zip", clear
		if (_rc != 0){
			di as error "Error in Test 4: Error in reading the written dataset"
		}


		if(c(N) != 20 | c(k)!=7) {
			di as error "Error in Test4 opendf write: Dataset dimensions not correct."
			local error_occured1="TRUE"
		}
		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "en de"){
			di as error "Error in Test4 opendf write: Languages not correct."
			local error_occured4="TRUE"
		}
		local _url : char _dta[url]
		local _dataset: char _dta[dataset]
		local _description_de: char _dta[description_de]
		local _description_en: char _dta[description_en]
		label language de
		local _label_de: data label
		label language en
		local _label_en: data label

		local _url_correct "."
		local _dataset_correct "bap"
		local _description_de_correct `"Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens „Leben in Deutschland – Befragung 2010 zur sozialen Lage - Personenfragebogen für alle“ erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im Haushalt. Eine Ansicht des Erhebungsinstrumentes finden Sie hier: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"' 
		local _description_en_correct `""'
		local _label_de_correct ""
		local _label_en_correct "Data from individual questionnaires 2010"


		if (`"`_url'"' != `"`_url_correct'"' | `"`_dataset'"' != `"`_dataset_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"') {
			di as error "Error in Test4 opendf write: Dataset Metadata not correct."
			local error_occured4="TRUE"
		}

		di "`_url'"
		di "`_url_correct'"
		di "`_dataset'"
		di "`_dataset_correct'"
		di "`_description_de'"
		di "`_description_de_correct'"
		di "`_description_en'"
		di "`_description_en_correct'"
		di "`_label_de'"
		di "`_label_de_correct'"
		di "`_label_en'"
		di "`_label_en_correct'"
		
		local _url : char bap9001[url]
		local _type: char bap9201[type]
		local _description_de: char bap87[description_de]
		local _description_en: char bap87[description_en]
		local _description2_de: char bap9002[description_de]
		local _description2_en: char bap9002[description_en]
		local _description3_de: char name[description_de]
		local _description3_en: char name[description_en]
		label language de
		local _label_de:  var label bap9003
		local _label2_de: var label bap96 
		label language en
		local _label_en: var label bap9003 
		local _label2_en: var label bap96 


		local _url_correct `"."'
		local _type_correct `"numeric"'
		local _description_de_correct `"Frage: Wie würden Sie Ihren gegenwärtigen Gesundheitszustand beschreiben?"' 
		local _description_en_correct `""'
		local _description2_de_correct `"Häufigkeit der Niedergeschlagenheit"' 
		local _description2_en_correct `""'
		local _description3_de_correct `"Vorname"' 
		local _description3_en_correct `""'
		local _label_de_correct `"Ausgeglichen letzten 4 Wochen"'
		local _label_en_correct `"Well-balanced Last 4 Weeks"'
		local _label2_de_correct `"Körpergröße"'
		local _label2_en_correct `"Height"'



		if (`"`_url'"' != `"`_url_correct'"' | `"`_type'"' != `"`_type_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' |`"`_description2_de'"' != `"`_description2_de_correct'"' | `"`_description2_en'"' != `"`_description2_en_correct'"' |`"`_description3_de'"' != `"`_description3_de_correct'"' | `"`_description3_en'"' != `"`_description3_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"' | `"`_label2_de'"' != `"`_label2_de_correct'"' | `"`_label2_en'"' != `"`_label2_en_correct'"') {
			di as error "Error in Test4 opendf write: Variable Metadata not correct."
			local error_occured4="TRUE"
		}

		di "`_url'"
		di "`_url_correct'"
		di "`_type'"
		di "`_type_correct'"
		di "`_description_de'"
		di "`_description_de_correct'"
		di "`_description2_de'"
		di "`_description2_de_correct'"
		di "`_description_en'"
		di "`_description_en_correct'"
		di "`_description2_en'"
		di "`_description2_en_correct'"
		di "`_label_de'"
		di "`_label_de_correct'"
		di "`_label_en'"
		di "`_label_en_correct'"
		di "`_label2_de'"
		di "`_label2_de_correct'"
		di "`_label2_en'"
		di "`_label2_en_correct'"
		
		label language en
		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9003[7]
		local _label3= "`:label (bap9003) `_val3''"

		local _val4=bap9002[11]
		local _label4= "`:label (bap9002) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap9001) `_val6''"

		local _val7=name[20]


		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton"){
			di as error "Error in Test4 opendf write: Values not correct."
			local error_occured4="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="No Answer" | "`_label4'"!="Always" | "`_label5'"!="8" | "`_label6'"!="Always"){
			di as error "Error in Test4 opendf write: English Value Labels not correct."
			local error_occured4="TRUE"
		}


		label language de

		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9003[7]
		local _label3= "`:label (bap9003) `_val3''"

		local _val4=bap9002[11]
		local _label4= "`:label (bap9002) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap9001) `_val6''"

		local _val7=name[20]
	
	
		di "`_label1'"
		di "`_label2'"
		di "`_label3'"
		di "`_label4'"
		di "`_label5'"
		di "`_label6'"

		di "`_val1'"
		di "`_val2'"
		di "`_val3'"
		di "`_val4'"
		di "`_val5'"
		di "`_val6'"
		di "`_val7'"

		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton"){
			di as error "Error in Test4 opendf write: Values not correct."
			local error_occured4="TRUE"
		}


		if("`_label1'"!="trifft nicht zu" | "`_label2'"!="." | "`_label3'"!="-1" | "`_label4'"!="Immer" | "`_label5'"!="8" | "`_label6'"!="Immer"){
			di as error "Error in Test4 opendf write: German Value Labels not correct."
			local error_occured4="TRUE"
		}






		*****************  Test 5: opendf write with testdata using input() option and variables option  ************
		local error_occured5 "FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"

		opendf write "$output_folder/testdata_out.zip", input("Datasets Testscripts\testdata") variables(bap87 bap96 bap9201 bap9001)
		if (_rc!=0){
			di as error "Error in Test 5 opendf write: Opendf Write didn't run successfully."
			local error_occured5="TRUE"
		}

		capture confirm file "$output_folder/testdata_out.zip"
		if (_rc!=0){
			di as error "Error in Test 5 opendf write: Opendf Write didn't run successfully."
			local error_occured5="TRUE"
		}

		opendf read "$output_folder/testdata_out.zip", clear

		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "en de"){
			di as error "Error in Test 5 opendf write: Opendf Write didn't save the languages properly."
			local error_occured5="TRUE"
		}


		if(c(N) != 20 | c(k)!=4) {
			di as error "Error in Test 5 opendf write: Dataset dimensions not correct."
			local error_occured5="TRUE"
		}
		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "en de"){
			di as error "Error in Test 5 opendf write: Languages not correct."
			local error_occured5="TRUE"
		}
		local _url : char _dta[url]
		local _dataset: char _dta[dataset]
		local _description_de: char _dta[description_de]
		local _description_en: char _dta[description_en]
		label language de
		local _label_de: data label
		label language en
		local _label_en: data label

		local _url_correct "https://paneldata.org/soep-core/data/bap"
		local _dataset_correct "bap"
		*local _description_de_correct `"Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens „Leben in Deutschland – Befragung 2010 zur sozialen *Lage - Personenfragebogen für alle" erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im Haushalt. Eine Ansicht des Erhebungsinstrumentes *finden Sie hier: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"' 
		local _description_en_correct `"The data were collected as part of the SOEP-Core study using the questionnaire "Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all. This questionnaire is addressed to the individual persons in the household. A view of the survey instrument can be found here: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"'
		local _label_de_correct "Daten vom Personenfragebogen 2010"
		local _label_en_correct "Data from individual questionnaires 2010"

		if (`"`_url'"' != `"`_url_correct'"' | `"`_dataset'"' != `"`_dataset_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"') {
			di as error "Error in Test 5 opendf write: Dataset Metadata not correct."
			local error_occured5="TRUE"
		}

		local _url : char bap87[url]
		local _type: char bap9201[type]
		local _description_de: char bap9001[description_de]
		local _description_en: char bap9001[description_en]
		local _description2_de: char bap9201[description_de]
		local _description2_en: char bap9201[description_en]
		local _description3_de: char bap96[description_de]
		local _description3_en: char bap96[description_en]
		label language de
		local _label_de:  var label bap9001
		local _label2_de: var label bap96 
		label language en
		local _label_en: var label bap9001 
		local _label2_en: var label bap96 


		local _url_correct `"https://paneldata.org/soep-core/data/bap/bap87"'
		local _type_correct `"numeric"'
		local _description_de_correct `"Häufigkeit des Gefühls von Zeitdruck in den letzten 4 Wochen"' 
		local _description_en_correct `"Frequency of feeling time pressure in the past 4 weeks"'
		local _description2_de_correct `"Schlafstunden pro Wochentag"' 
		local _description2_en_correct `"Sleep hours per weekday"'
		local _description3_de_correct `"Körpergröße"' 
		local _description3_en_correct `"Body size"'
		local _label_de_correct `"Eile, Zeitdruck letzten 4 Wochen"'
		local _label_en_correct `"Pressed For Time Last 4 Weeks"'
		local _label2_de_correct `"Körpergröße"'
		local _label2_en_correct `"Height"'

		if (`"`_url'"' != `"`_url_correct'"' | `"`_type'"' != `"`_type_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' |`"`_description2_de'"' != `"`_description2_de_correct'"' | `"`_description2_en'"' != `"`_description2_en_correct'"' |`"`_description3_de'"' != `"`_description3_de_correct'"' | `"`_description3_en'"' != `"`_description3_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"' | `"`_label2_de'"' != `"`_label2_de_correct'"' | `"`_label2_en'"' != `"`_label2_en_correct'"') {
			di as error "Error in Test 5 opendf write: Variable Metadata not correct."
			local error_occured5="TRUE"
		}

		label language en
		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9001[7]
		local _label3= "`:label (bap9001) `_val3''"

		local _val4=bap9001[11]
		local _label4= "`:label (bap9001) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap87[8]
		local _label6= "`:label (bap87) `_val6''"



		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=2 | `_val4'!=2 | `_val5'!=8 | `_val6'!=5){
			di as error "Error in Test 5 opendf write: Values not correct."
			local error_occured5="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="Often" | "`_label4'"!="Often" | "`_label5'"!="8" | "`_label6'"!="Bad"){
			di as error "Error in Test 5 opendf write: Value Labels not correct."
			local error_occured5="TRUE"
		}


		label language de

		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9001[7]
		local _label3= "`:label (bap9001) `_val3''"

		local _val4=bap9201[11]
		local _label4= "`:label (bap9201) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap87) `_val6''"



		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=2 | `_val4'!=4 | `_val5'!=8 | `_val6'!=1 ){
			di as error "Error in Test 5 opendf write: Values not correct."
			local error_occured5="TRUE"
		}

		if("`_label1'"!="trifft nicht zu" | "`_label2'"!="." | "`_label3'"!="Oft" | "`_label4'"!="4" | "`_label5'"!="8" | "`_label6'"!="Sehr gut"){
			di as error "Error in Test 5 opendf write: Value Labels not correct."
			local error_occured5="TRUE"
		}




		*****************  Test 6: opendf write with testdata using input() option  ************
		local error_occured6 "FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		opendf write "$output_folder/testdata_out.zip", input("Datasets Testscripts\testdata") variables(bap87 bap96 bap9201 bap9001)
		if (_rc!=0){
			di as error "Error in Test 6 opendf write: Opendf Write didn't run successfully."
			local error_occured6="TRUE"
		}

		capture confirm file "$output_folder/testdata_out.zip"
		if (_rc!=0){
			di as error "Error in Test 6 opendf write: Opendf Write didn't run successfully."
			local error_occured6="TRUE"
		}

		opendf read "$output_folder/testdata_out.zip", clear

		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "en de"){
			di as error "Error in Test 6 opendf write: Opendf Write didn't save the languages properly."
			local error_occured6="TRUE"
		}


		if(c(N) != 20 | c(k)!=4) {
			di as error "Error in Test 6 opendf write: Dataset dimensions not correct."
			local error_occured6="TRUE"
		}
		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "en de"){
			di as error "Error in Test 6 opendf write: Languages not correct."
			local error_occured6="TRUE"
		}
		local _url : char _dta[url]
		local _dataset: char _dta[dataset]
		local _description_de: char _dta[description_de]
		local _description_en: char _dta[description_en]
		label language de
		local _label_de: data label
		label language en
		local _label_en: data label

		local _url_correct "https://paneldata.org/soep-core/data/bap"
		local _dataset_correct "bap"
		*local _description_de_correct `"Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens „Leben in Deutschland – Befragung 2010 zur sozialen *Lage - Personenfragebogen für alle" erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im Haushalt. Eine Ansicht des Erhebungsinstrumentes *finden Sie hier: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"' 
		local _description_en_correct `"The data were collected as part of the SOEP-Core study using the questionnaire "Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all. This questionnaire is addressed to the individual persons in the household. A view of the survey instrument can be found here: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"'
		local _label_de_correct "Daten vom Personenfragebogen 2010"
		local _label_en_correct "Data from individual questionnaires 2010"


		if (`"`_url'"' != `"`_url_correct'"' | `"`_dataset'"' != `"`_dataset_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"') {
			di as error "Error in Test 6 opendf write: Dataset Metadata not correct."
			local error_occured6="TRUE"
		}

		local _url : char bap87[url]
		local _type: char bap9201[type]
		local _description_de: char bap9001[description_de]
		local _description_en: char bap9001[description_en]
		local _description2_de: char bap9201[description_de]
		local _description2_en: char bap9201[description_en]
		local _description3_de: char bap96[description_de]
		local _description3_en: char bap96[description_en]
		label language de
		local _label_de:  var label bap9001
		local _label2_de: var label bap96 
		label language en
		local _label_en: var label bap9001 
		local _label2_en: var label bap96 


		local _url_correct `"https://paneldata.org/soep-core/data/bap/bap87"'
		local _type_correct `"numeric"'
		local _description_de_correct `"Häufigkeit des Gefühls von Zeitdruck in den letzten 4 Wochen"' 
		local _description_en_correct `"Frequency of feeling time pressure in the past 4 weeks"'
		local _description2_de_correct `"Schlafstunden pro Wochentag"' 
		local _description2_en_correct `"Sleep hours per weekday"'
		local _description3_de_correct `"Körpergröße"' 
		local _description3_en_correct `"Body size"'
		local _label_de_correct `"Eile, Zeitdruck letzten 4 Wochen"'
		local _label_en_correct `"Pressed For Time Last 4 Weeks"'
		local _label2_de_correct `"Körpergröße"'
		local _label2_en_correct `"Height"'

		if (`"`_url'"' != `"`_url_correct'"' | `"`_type'"' != `"`_type_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' |`"`_description2_de'"' != `"`_description2_de_correct'"' | `"`_description2_en'"' != `"`_description2_en_correct'"' |`"`_description3_de'"' != `"`_description3_de_correct'"' | `"`_description3_en'"' != `"`_description3_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"' | `"`_label2_de'"' != `"`_label2_de_correct'"' | `"`_label2_en'"' != `"`_label2_en_correct'"') {
			di as error "Error in Test 6 opendf write: Variable Metadata not correct."
			local error_occured6="TRUE"
		}

		label language en
		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9001[7]
		local _label3= "`:label (bap9001) `_val3''"

		local _val4=bap9001[11]
		local _label4= "`:label (bap9001) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap87[8]
		local _label6= "`:label (bap87) `_val6''"


		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=2 | `_val4'!=2 | `_val5'!=8 | `_val6'!=5){
			di as error "Error in Test 6 opendf write: Values not correct."
			local error_occured6="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="Often" | "`_label4'"!="Often" | "`_label5'"!="8" | "`_label6'"!="Bad"){
			di as error "Error in Test 6 opendf write: Value Labels not correct."
			local error_occured6="TRUE"
		}


		label language de

		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9001[7]
		local _label3= "`:label (bap9001) `_val3''"

		local _val4=bap9201[11]
		local _label4= "`:label (bap9201) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap87) `_val6''"


		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=2 | `_val4'!=4 | `_val5'!=8 | `_val6'!=1 ){
			di as error "Error in Test 6 opendf write: Values not correct."
			local error_occured6="TRUE"
		}

		if("`_label1'"!="trifft nicht zu" | "`_label2'"!="." | "`_label3'"!="Oft" | "`_label4'"!="4" | "`_label5'"!="8" | "`_label6'"!="Sehr gut"){
			di as error "Error in Test 6 opendf write: Value Labels not correct."
			local error_occured6="TRUE"
		}





		*****************  Test 7: opendf write with testdata with default language wiriting only language de  ************
		local error_occured7 "FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		opendf write "$output_folder/testdata_out_de.zip", input("Datasets Testscripts\testdata_with_default") languages("de") replace
		if (_rc!=0){
			di as error "Error in Test 7 opendf write: Opendf Write didn't run successfully."
			local error_occured7="TRUE"
		}

		capture confirm file "$output_folder/testdata_out_de.zip"
		if (_rc!=0){
			di as error "Error in Test 7 opendf write: Opendf Write didn't run successfully."
			local error_occured7="TRUE"
		}

		opendf read "$output_folder/testdata_out_de.zip", clear

		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "de"){
			di as error "Error in Test 7 opendf write: Opendf Write didn't save the languages properly."
			local error_occured7="TRUE"
		}


		if(c(N) != 20 | c(k)!=7) {
			di as error "Error in Test 7 opendf write: Dataset dimensions not correct."
			local error_occured7="TRUE"
		}

		local _url : char _dta[url]
		local _dataset: char _dta[dataset]
		local _description_de: char _dta[description_de]
		local _description_en: char _dta[description_en]
		local _label_de: data label



		local _url_correct "https://paneldata.org/soep-core/data/bap"
		local _dataset_correct "bap"
		*local _description_de_correct `"Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens „Leben in Deutschland – Befragung 2010 zur sozialen *Lage - Personenfragebogen für alle" erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im Haushalt. Eine Ansicht des Erhebungsinstrumentes *finden Sie hier: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"' 
		local _description_en_correct `""'
		local _label_de_correct "Daten vom Personenfragebogen 2010"

		if (`"`_url'"' != `"`_url_correct'"' | `"`_dataset'"' != `"`_dataset_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' ) {
			di as error "Error in Test 7 opendf write: Dataset Metadata not correct."
			local error_occured7="TRUE"
		}

		local _url : char bap87[url]
		local _type: char bap9201[type]
		local _description_de: char bap9001[description_de]
		local _description_en: char bap9001[description_en]
		local _description2_de: char bap9201[description_de]
		local _description2_en: char bap9201[description_en]
		local _description3_de: char bap96[description_de]
		local _description3_en: char bap96[description_en]
		local _label_de:  var label bap9001
		local _label2_de: var label bap96 


		local _url_correct `"https://paneldata.org/soep-core/data/bap/bap87"'
		local _type_correct `"numeric"'
		local _description_de_correct `"Häufigkeit des Gefühls von Zeitdruck in den letzten 4 Wochen"' 
		local _description_en_correct `""'
		local _description2_de_correct `"Schlafstunden pro Wochentag"' 
		local _description2_en_correct `""'
		local _description3_de_correct `"Körpergröße"' 
		local _description3_en_correct `""'
		local _label_de_correct `"Eile, Zeitdruck letzten 4 Wochen"'
		local _label2_de_correct `"Körpergröße"'

		if (`"`_url'"' != `"`_url_correct'"' | `"`_type'"' != `"`_type_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' |`"`_description2_de'"' != `"`_description2_de_correct'"' | `"`_description2_en'"' != `"`_description2_en_correct'"' |`"`_description3_de'"' != `"`_description3_de_correct'"' | `"`_description3_en'"' != `"`_description3_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label2_de'"' != `"`_label2_de_correct'"' ) {
			di as error "Error in Test 7 opendf write: Variable Metadata not correct."
			local error_occured7="TRUE"
		}



		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9001[7]
		local _label3= "`:label (bap9001) `_val3''"

		local _val4=bap9201[11]
		local _label4= "`:label (bap9201) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap87) `_val6''"



		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=2 | `_val4'!=4 | `_val5'!=8 | `_val6'!=1 ){
			di as error "Error in Test 7 opendf write: Values not correct."
			local error_occured7="TRUE"
		}

		if("`_label1'"!="trifft nicht zu" | "`_label2'"!="." | "`_label3'"!="Oft" | "`_label4'"!="4" | "`_label5'"!="8" | "`_label6'"!="Sehr gut"){
			di as error "Error in Test 7 opendf write: Value Labels not correct."
			local error_occured7="TRUE"
		}





		*****************  Test 8: opendf write with testdata with default language wiriting only language de  ************
		local error_occured8 "FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		opendf write "$output_folder/testdata_out_de.zip", input("Datasets Testscripts\testdata_with_default") languages("default") replace
		if (_rc!=0){
			di as error "Error in Test 8 opendf write: Opendf Write didn't run successfully."
			local error_occured8="TRUE"
		}

		capture confirm file "$output_folder/testdata_out_de.zip"
		if (_rc!=0){
			di as error "Error in Test 8 opendf write: Opendf Write didn't run successfully."
			local error_occured8="TRUE"
		}

		opendf read "$output_folder/testdata_out_de.zip", clear

		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "default"){
			di as error "Error in Test 8 opendf write: Opendf Write didn't save the languages properly."
			local error_occured8="TRUE"
		}


		if(c(N) != 20 | c(k)!=7) {
			di as error "Error in Test 8 opendf write: Dataset dimensions not correct."
			local error_occured8="TRUE"
		}

		local _url : char _dta[url]
		local _dataset: char _dta[dataset]
		local _description_default: char _dta[description]
		local _label_default: data label



		local _url_correct "https://paneldata.org/soep-core/data/bap"
		local _dataset_correct "bap"
		*local _description_de_correct `"Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens „Leben in Deutschland – Befragung 2010 zur sozialen *Lage - Personenfragebogen für alle" erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im Haushalt. Eine Ansicht des Erhebungsinstrumentes *finden Sie hier: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"' 
		local _description_default_correct `"The data were collected as part of the SOEP-Core study using the questionnaire "Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all. This questionnaire is addressed to the individual persons in the household. A view of the survey instrument can be found here: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"'
		local _label_default_correct "Data from individual questionnaires 2010"


		if (`"`_url'"' != `"`_url_correct'"' | `"`_dataset'"' != `"`_dataset_correct'"' | `"`_description_default'"' != `"`_description_default_correct'"' | `"`_label_default'"' != `"`_label_default_correct'"' ) {
			di as error "Error in Test 8 opendf write: Dataset Metadata not correct."
			local error_occured8="TRUE"
		}


		local _url : char bap87[url]
		local _type: char bap9201[type]
		local _description_default: char bap9001[description]


		local _description2_default: char bap9002[description]

		local _description3_default: char name[description]

		local _label_default:  var label bap9003
		local _label2_default: var label bap96 


		local _url_correct `"https://paneldata.org/soep-core/data/bap/bap87"'
		local _type_correct `"numeric"'
		local _description_default_correct `"Frequency of feeling time pressure in the past 4 weeks"' 
		local _description2_default_correct `"Frequency of feeling a sad and depressed state"'
		local _description3_default_correct `"Firstname"'
		local _label_default_correct `"Well-balanced Last 4 Weeks"'
		local _label2_default_correct `"Height"'

		if (`"`_url'"' != `"`_url_correct'"' | `"`_type'"' != `"`_type_correct'"' | `"`_description_default'"' != `"`_description_default_correct'"' | `"`_description2_default'"' != `"`_description2_default_correct'"'| `"`_description3_default'"' != `"`_description3_default_correct'"' | `"`_label_default'"' != `"`_label_default_correct'"' | `"`_label2_default'"' != `"`_label2_default_correct'"') {
			di as error "Error in Test 8 opendf write: Variable Metadata not correct."
			local error_occured3="TRUE"
		}


		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9003[7]
		local _label3= "`:label (bap9003) `_val3''"

		local _val4=bap9002[11]
		local _label4= "`:label (bap9002) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap9001) `_val6''"

		local _val7=name[20]

		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton"){
			di as error "Error in Test 8 opendf write: Values not correct."
			local error_occured3="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="No Answer" | "`_label4'"!="Always" | "`_label5'"!="8" | "`_label6'"!="Always"){
			di as error "Error in Test 8 opendf write: Value Labels not correct."
			local error_occured3="TRUE"
		}




		*****************  Test 9: opendf write with testdata with default language writing only language de and default  ************
		local error_occured9 "FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		opendf write "$output_folder/testdata_out_de.zip", input("Datasets Testscripts\testdata_with_default") languages("de default") replace
		if (_rc!=0){
			di as error "Error in Test 9 opendf write: Opendf Write didn't run successfully."
			local error_occured9="TRUE"
		}

		capture confirm file "$output_folder/testdata_out_de.zip"
		if (_rc!=0){
			di as error "Error in Test 9 opendf write: Opendf Write didn't run successfully."
			local error_occured9="TRUE"
		}

		opendf read "$output_folder/testdata_out_de.zip", clear

		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "default de"){
			di as error "Error in Test 9 opendf write: Opendf Write didn't save the languages properly."
			local error_occured9="TRUE"
		}


		if(c(N) != 20 | c(k)!=7) {
			di as error "Error in Test 9 opendf write: Dataset dimensions not correct."
			local error_occured9="TRUE"
		}

		local _url : char _dta[url]
		local _dataset: char _dta[dataset]
		local _description_default: char _dta[description]
		*local _description_de: char _dta[description_de]
		label language default
		local _label_default: data label
		label language de
		local _label_de: data label

		local _url_correct "https://paneldata.org/soep-core/data/bap"
		local _dataset_correct "bap"
		*local _description_de_correct `"Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens „Leben in Deutschland – Befragung 2010 zur sozialen *Lage - Personenfragebogen für alle" erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im Haushalt. Eine Ansicht des Erhebungsinstrumentes *finden Sie hier: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"' 
		local _description_default_correct `"The data were collected as part of the SOEP-Core study using the questionnaire "Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all. This questionnaire is addressed to the individual persons in the household. A view of the survey instrument can be found here: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"'
		local _label_de_correct "Daten vom Personenfragebogen 2010"
		local _label_default_correct "Data from individual questionnaires 2010"

		if (`"`_url'"' != `"`_url_correct'"' | `"`_dataset'"' != `"`_dataset_correct'"' |`"`_description_default'"' != `"`_description_default_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_default'"' != `"`_label_default_correct'"' ) {
			di as error "Error in Test 9 opendf write: Dataset Metadata not correct."
			local error_occured9="TRUE"
		}

		local _url : char bap87[url]
		local _type: char bap9201[type]
		local _description_default: char bap9001[description]
		local _description_de: char bap9001[description_de]
		local _description2_default: char bap9002[description]
		local _description2_de: char bap9002[description_de]
		local _description3_default: char name[description]
		local _description3_de: char name[description_de]
		label language default
		local _label_default:  var label bap9003
		local _label2_default: var label bap96 
		label language de
		local _label_de:  var label bap9003
		local _label2_de: var label bap96 


		local _url_correct `"https://paneldata.org/soep-core/data/bap/bap87"'
		local _type_correct `"numeric"'
		local _description_default_correct `"Frequency of feeling time pressure in the past 4 weeks"' 
		local _description_de_correct `"Häufigkeit des Gefühls von Zeitdruck in den letzten 4 Wochen"' 
		local _description2_default_correct `"Frequency of feeling a sad and depressed state"'
		local _description2_de_correct `"Häufigkeit der Niedergeschlagenheit"' 
		local _description3_default_correct `"Firstname"'
		local _description3_de_correct `"Vorname"' 
		local _label_default_correct `"Well-balanced Last 4 Weeks"'
		local _label_de_correct `"Ausgeglichen letzten 4 Wochen"'
		local _label2_default_correct `"Height"'
		local _label2_de_correct `"Körpergröße"'

		if (`"`_url'"' != `"`_url_correct'"' | `"`_type'"' != `"`_type_correct'"' | `"`_description_default'"' != `"`_description_default_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' |  `"`_description2_default'"' != `"`_description2_default_correct'"'|`"`_description2_de'"' != `"`_description2_de_correct'"' |  `"`_description3_default'"' != `"`_description3_default_correct'"' |`"`_description3_de'"' != `"`_description3_de_correct'"'  | `"`_label_default'"' != `"`_label_default_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label2_default'"' != `"`_label2_default_correct'"'  | `"`_label2_de'"' != `"`_label2_de_correct'"') {
			di as error "Error in Test 9 opendf write: Variable Metadata not correct."
			local error_occured9="TRUE"
		}

		label language default

		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9003[7]
		local _label3= "`:label (bap9003) `_val3''"

		local _val4=bap9002[11]
		local _label4= "`:label (bap9002) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap9001) `_val6''"

		local _val7=name[20]

		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton"){
			di as error "Error in Test 9 opendf write: Values not correct."
			local error_occured9="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="No Answer" | "`_label4'"!="Always" | "`_label5'"!="8" | "`_label6'"!="Always"){
			di as error "Error in Test 9 opendf write: Value Labels not correct."
			local error_occured9="TRUE"
		}

		label language de

		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		local _val2=bap87[3]
		local _label2= "`:label (bap87) `_val2''"

		local _val3=bap9003[7]
		local _label3= "`:label (bap9003) `_val3''"

		local _val4=bap9002[11]
		local _label4= "`:label (bap9002) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap9001) `_val6''"

		local _val7=name[20]


		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton"){
			di as error "Error in Test 9 opendf write: Values not correct."
			local error_occured9="TRUE"
		}

		if("`_label1'"!="trifft nicht zu" | "`_label2'"!="." | "`_label3'"!="keine Angabe" | "`_label4'"!="Immer" | "`_label5'"!="8" | "`_label6'"!="Immer"){
			di as error "Error in Test 9 opendf write: Value Labels not correct."
			local error_occured9="TRUE"
		}
	}









	********Display if all tests were sucessful
	clear 

	if("`error_occured1'" =="FALSE" & "`error_occured2'" =="FALSE" & "`error_occured3'" =="FALSE" & "`error_occured4'" =="FALSE" & "`error_occured5'"=="FALSE" & "`error_occured6'"=="FALSE" & "`error_occured6'"=="FALSE" & "`error_occured7'"=="FALSE" & "`error_occured8'"=="FALSE" & "`error_occured9'"=="FALSE"){
		di "Test opendf write successful"
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
		
		if("`error_occured4'" =="FALSE"){
			di "Test 4 Successful"
		}
		else {
			di "Test 4 not successful"
		}
		if("`error_occured5'" =="FALSE"){
			di "Test 5 Successful"
		}
		else {
			di "Test 5 not successful"
		}
		if("`error_occured6'" =="FALSE"){
			di "Test 6 Successful"
		}
		else {
			di "Test 6 not successful"
		}
		if("`error_occured7'" =="FALSE"){
			di "Test 7 Successful"
		}
		else {
			di "Test 7 not successful"
		}
		if("`error_occured8'" =="FALSE"){
			di "Test 8 Successful"
		}
		else {
			di "Test 8 not successful"
		}
		if("`error_occured9'" =="FALSE"){
			di "Test 9 Successful"
		}
		else {
			di "Test 9 not successful"
		}
	}

end
