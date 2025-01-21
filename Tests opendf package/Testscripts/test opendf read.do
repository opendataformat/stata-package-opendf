*test opendf read



***************Test 1 opendf read: read dataset without any options ********************
program define test_opendf_read
	quietly {
		local error_occured1="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"

		opendf read "Datasets Testscripts\data.zip", clear
		capture confirm file "$output_folder\testdata"
		if (_rc != 601){
			noisily: di as error "Error in Test 1 opendf read: Zip-File not created."
			local error_occured1="TRUE"
		}


		if(c(N) != 20 | c(k)!=7) {
			noisily: di as error "Error in Test 1 opendf read: Dataset dimensions not correct."
			local error_occured1="TRUE"
		}
		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "en de"){
			noisily: di as error "Error in Test 1 opendf read: Languages not correct."
			local error_occured1="TRUE"
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
			noisily: di as error "Error in Test 1 opendf read: Dataset Metadata not correct."
			local error_occured1="TRUE"
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

		di "`_url'"
		di "`_type'"
		di "`_description_de'"
		di "`_description_en'"
		di "`_description2_de'"
		di "`_description2_en'"
		di "`_description3_de'"
		di "`_description3_en'"
		di "`_label_de'"
		di "`_label_en'"
		di "`_label2_de'"
		di "`_label2_en'"
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
			noisily: di as error "Error in Test 1 opendf read: Variable Metadata not correct."
			local error_occured1="TRUE"
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

		local _vals_name: char name[labelled_values]
		local _vals_name_correct = "-2<;>-1"
		local _labels_name_en : char name[value_labels_en]
		local _labels_name_en_cor = "Does not apply<;>No Answer"

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


		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton" | "`_vals_name'" != "`_vals_name_correct'"){
			noisily: di as error "Error in Test 1 opendf read: Values not correct."
			local error_occured1="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="No Answer" | "`_label4'"!="Always" | "`_label5'"!="8" | "`_label6'"!="Always" | "`_labels_name_en'" != "`_labels_name_en_cor'"){
			noisily: di as error "Error in Test 1 opendf read: Value Labels not correct."
			local error_occured1="TRUE"
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
		
		local _vals_name: char name[labelled_values]
		local _vals_name_correct = "-2<;>-1"
		local _labels_name_de : char name[value_labels_de]
		local _labels_name_de_cor = "trifft nicht zu<;>keine Angabe"
		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton" | "`_vals_name'" != "`_vals_name_correct'"){
			noisily: di as error "Error in Test 1 opendf read: Values not correct."
			local error_occured1="TRUE"
		}

		if("`_label1'"!="trifft nicht zu" | "`_label2'"!="." | "`_label3'"!="keine Angabe" | "`_label4'"!="Immer" | "`_label5'"!="8" | "`_label6'"!="Immer" | "`_labels_name_de'" != "`_labels_name_de_cor'"){
			noisily: di as error "Error in Test 1 opendf read: Value Labels not correct."
			local error_occured1="TRUE"
		}


		****************Test2 : read dataset with save option *******************
		local error_occured2="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		capture opendf read "Datasets Testscripts\data.zip", save("$output_folder/testdata") replace clear verbose
		if (_rc != 0){
			noisily: di as error "Error in Test 2 opendf read: Error in loading Dataset"
			local error_occured2="TRUE"
		}


		capture confirm file "$output_folder\testdata.dta"
		if (_rc != 0){
			noisily: di as error "Error in Test 2 opendf read: Saving Datasat as .dta not successful"
			local error_occured2="TRUE"
		}

		capture opendf read "Datasets Testscripts\data.zip", save("$output_folder/testdata") clear verbose
		
		if (_rc != 602){
			noisily: di as error "Error in Test 2 opendf read: File should have returned Error Message '"'file H:/Testdaten/Output Testscripts/testdata.dta already exists' because option 'replace' is missing"
			local error_occured2="TRUE"
		}

		capture opendf read "Datasets Testscripts\data.zip", save("$output_folder/testdata") clear replace verbose
		di _rc
		if (_rc!=0){
			noisily: di as error "Error in Test 2 opendf read: Error in reloading Dataset"
			local error_occured2="TRUE"
		}
		if(c(N) != 20 | c(k)!=7) {
			noisily: di as error "Error in Test 2 opendf read: Dataset dimensions not correct."
			local error_occured2="TRUE"
			local error_occured2="TRUE"
		}
		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "en de"){
			noisily: di as error "Error in Test 2 opendf read: Languages not correct."
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
			noisily: di as error "Error in Test 2 opendf read: Dataset Metadata not correct."
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
			noisily: di as error "Error in Test 2 opendf read: Variable Metadata not correct."
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


		if(`_val1'!=-2 | `_val2'!=. | `_val3'!=-1 | `_val4'!=1 | `_val5'!=8 | `_val6'!=1 | "`_val7'"!="Anton"){
			noisily: di as error "Error in Test 2 opendf read: Values not correct."
			local error_occured2="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="No Answer" | "`_label4'"!="Always" | "`_label5'"!="8" | "`_label6'"!="Always"){
			noisily: di as error "Error in Test 2 opendf read: Value Labels not correct."
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
			noisily: di as error "Error in Test 2 opendf read: Values not correct."
			local error_occured2="TRUE"
		}

		if("`_label1'"!="trifft nicht zu" | "`_label2'"!="." | "`_label3'"!="keine Angabe" | "`_label4'"!="Immer" | "`_label5'"!="8" | "`_label6'"!="Immer"){
			noisily: di as error "Error in Test 2 opendf read: Value Labels not correct."
			local error_occured2="TRUE"
		}






		******************** Test 3 opendf read: read dataset with default language (meta data without language tag) *******************
		local error_occured3="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		opendf read "Datasets Testscripts\data_with_default.zip", save("$output_folder\testdata_default_language") replace clear

		capture confirm file "$output_folder\testdata_default_language.dta"
		if (_rc!=0){
			 noisily: di as error "Error in Test 3 opendf read: Dataset not saved successfully with options saved."
			local error_occured3="TRUE"
		}

		if(c(N) != 20 | c(k)!=7) {
			noisily: di as error "Error in Test 3 opendf read: Dataset dimensions not correct."
			local error_occured3="TRUE"
		}
		local _languages: char _dta[_lang_list]
		di "`_languages'"
		if ("`_languages'" != "default en de"){
			noisily: di as error "Error in Test 3 opendf read: Languages not correct."
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
			noisily: di as error "Error in Test 3 opendf read: Dataset Metadata not correct."
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

		di "`_url'"
		di "`_type'"
		di "`_description_default'"
		di "`_description_de'"
		di "`_description_en'"
		di "`_description2_default'"
		di "`_description2_de'"
		di "`_description2_en'"
		di "`_description3_default'"
		di "`_description3_de'"
		di "`_description3_en'"
		di "`_label_default'"
		di "`_label_de'"
		di "`_label_en'"
		di "`_label2_default'"
		di "`_label2_de'"
		di "`_label2_en'"
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
			noisily: di as error "Error in Test 3 opendf read: Variable Metadata not correct."
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
			noisily: di as error "Error in Test 3 opendf read: Values not correct."
			local error_occured3="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="No Answer" | "`_label4'"!="Always" | "`_label5'"!="8" | "`_label6'"!="Always"){
			noisily: di as error "Error in Test 3 opendf read: Value Labels not correct."
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
			noisily: di as error "Error in Test 3 opendf read: Values not correct."
			local error_occured3="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="No Answer" | "`_label4'"!="Always" | "`_label5'"!="8" | "`_label6'"!="Always"){
			noisily: di as error "Error in Test 3 opendf read: Value Labels not correct."
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
			noisily: di as error "Error in Test 3 opendf read: Values not correct."
			local error_occured3="TRUE"
		}

		if("`_label1'"!="trifft nicht zu" | "`_label2'"!="." | "`_label3'"!="keine Angabe" | "`_label4'"!="Immer" | "`_label5'"!="8" | "`_label6'"!="Immer"){
			noisily: di as error "Error in Test 3 opendf read: Value Labels not correct."
			local error_occured3="TRUE"
		}


		********************      read dataset with missings and special characters *******************
		local error_occured4="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		
		opendf read "Datasets Testscripts\data_with_missings.zip", save("$output_folder\testdata_missings") clear replace
		capture confirm file "$output_folder\testdata"
		if (_rc != 601){
			noisily: di as error "Error in Test 4 opendf read"
		}


		if(c(N) != 20 | c(k)!=7) {
			noisily: di as error "Error in Test 4 opendf read: Dataset dimensions not correct."
			local error_occured1="TRUE"
		}
		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "en de"){
			noisily: di as error "Error in Test 4 opendf read: Languages not correct."
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
		di `"`_url'"'
		di `"`_dataset'"'
		di `"`_description_de'"'
		di `"`_description_en'"'
		di `"`_label_de'"'
		di `"`_label_en'"'
		local _url_correct "."
		local _dataset_correct "bap"
		local _description_de_correct `"Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens „Leben in Deutschland – Befragung 2010 zur sozialen Lage - Personenfragebogen für alle“ erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im Haushalt. Eine Ansicht des Erhebungsinstrumentes finden Sie hier: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"' 
		local _description_en_correct `""'
		local _label_de_correct ""
		local _label_en_correct "Data from individual questionnaires 2010"


		if (`"`_url'"' != `"`_url_correct'"' | `"`_dataset'"' != `"`_dataset_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"') {
			noisily: di as error "Error in Test 4 opendf read: Dataset Metadata not correct."
			local error_occured4="TRUE"
		}

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

		di `"`_url'"'
		di `"`_type'"'
		di `"`_description_de'"'
		di `"`_description_en'"'
		di `"`_description2_de'"'
		di `"`_description2_en'"'
		di `"`_description3_de'"'
		di `"`_description3_en'"'
		di `"`_label_de'"'
		di `"`_label_en'"'
		di `"`_label2_de'"'
		di `"`_label2_en'"'
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
			noisily: di as error "Error in Test 4 opendf read: Variable Metadata not correct."
			local error_occured4="TRUE"
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
			noisily: di as error "Error in Test 4 opendf read: Values not correct."
			local error_occured4="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label2'"!="." | "`_label3'"!="No Answer" | "`_label4'"!="Always" | "`_label5'"!="8" | "`_label6'"!="Always"){
			noisily: di as error "Error in Test 4 opendf read: Value Labels not correct."
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
			noisily: di as error "Error in Test 4 opendf read: Values not correct."
			local error_occured4="TRUE"
		}

		if("`_label1'"!="trifft nicht zu" | "`_label2'"!="." | "`_label3'"!="-1" | "`_label4'"!="Immer" | "`_label5'"!="8" | "`_label6'"!="Immer"){
			noisily: di as error "Error in Test 4 opendf read: Value Labels not correct."
			local error_occured4="TRUE"
		}


		
		******************** Test 5 opendf read: read rowrange and colrange of dataset  *******************
		local error_occured5="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		opendf read "Datasets Testscripts\data.zip", rowrange(:10) colrange(2:) clear

		
		if(c(N) != 10 | c(k)!=6) {
			noisily: di as error "Error in Test 5 opendf read: Dataset dimensions not correct."
			local error_occured5="TRUE"
		}
		local _languages: char _dta[_lang_list]
		if ("`_languages'" != "en de"){
			noisily: di as error "Error in Test 5 opendf read: Languages not correct."
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
		local _description_de_correct `"Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens „Leben in Deutschland – Befragung 2010 zur sozialen Lage - Personenfragebogen für alle“ erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im Haushalt. Eine Ansicht des Erhebungsinstrumentes finden Sie hier: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"' 
		local _description_en_correct `"The data were collected as part of the SOEP-Core study using the questionnaire "Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all. This questionnaire is addressed to the individual persons in the household. A view of the survey instrument can be found here: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf"'
		local _label_de_correct "Daten vom Personenfragebogen 2010"
		local _label_en_correct "Data from individual questionnaires 2010"

		*di "`_description_de'"
		*di "`_description_de_correct'"
		
		if (`"`_url'"' != `"`_url_correct'"' | `"`_dataset'"' != `"`_dataset_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"') {
			noisily: di as error "Error in Test 5 opendf read: Dataset Metadata not correct."
			local error_occured5="TRUE"
		}

		capture local _url : char bap87[url]
		if (_rc != 111){
			noisily: di as error "Error in Test 5 opendf read: Wrong columns read in the dataset."
			local error_occured5="TRUE"
		}
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

		di "`_type'"
		di "`_description_de'"
		di "`_description_en'"
		di "`_description2_de'"
		di "`_description2_en'"
		di "`_description3_de'"
		di "`_description3_en'"
		di "`_label_de'"
		di "`_label_en'"
		di "`_label2_de'"
		di "`_label2_en'"
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

		if (`"`_type'"' != `"`_type_correct'"' | `"`_description_de'"' != `"`_description_de_correct'"' | `"`_description_en'"' != `"`_description_en_correct'"' |`"`_description2_de'"' != `"`_description2_de_correct'"' | `"`_description2_en'"' != `"`_description2_en_correct'"' |`"`_description3_de'"' != `"`_description3_de_correct'"' | `"`_description3_en'"' != `"`_description3_en_correct'"' | `"`_label_de'"' != `"`_label_de_correct'"' | `"`_label_en'"' != `"`_label_en_correct'"' | `"`_label2_de'"' != `"`_label2_de_correct'"' | `"`_label2_en'"' != `"`_label2_en_correct'"') {
			noisily: di as error "Error in Test 5 opendf read: Variable Metadata not correct."
			local error_occured5="TRUE"
		}

		label language en
		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		
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
		di "`_label3'"
		di "`_label4'"
		di "`_label5'"
		di "`_label6'"

		di "`_val1'"
		di "`_val3'"
		di "`_val4'"
		di "`_val5'"
		di "`_val6'"
		di "`_val7'"


		if(`_val1'!=-2 | `_val3'!=-1 | `_val4'!=. | `_val5'!=. | `_val6'!=1 | "`_val7'"!=""){
			noisily: di as error "Error in Test 5 opendf read: Values not correct."
			local error_occured5="TRUE"
		}

		if("`_label1'"!="Does not apply" | "`_label3'"!="No Answer" | "`_label4'"!="." | "`_label5'"!="." | "`_label6'"!="Always"){
			noisily: di as error "Error in Test 5 opendf read: Value Labels not correct."
			local error_occured5="TRUE"
		}


		label language de

		local _val1=bap96[1]
		local _label1= "`:label (bap96) `_val1''"

		
		local _val3=bap9003[7]
		local _label3= "`:label (bap9003) `_val3''"

		local _val4=bap9002[11]
		local _label4= "`:label (bap9002) `_val4''"

		local _val5=bap9201[19]
		local _label5= "`:label (bap9201) `_val5''"

		local _val6=bap9001[8]
		local _label6= "`:label (bap9001) `_val6''"

		local _val7=name[20]

		if(`_val1'!=-2 | `_val3'!=-1 | `_val4'!=. | `_val5'!=. | `_val6'!=1 | "`_val7'"!=""){
			noisily: di as error "Error in Test 5 opendf read: Values not correct."
			local error_occured5="TRUE"
		}

		if("`_label1'"!="trifft nicht zu" | "`_label3'"!="keine Angabe" | "`_label4'"!="." | "`_label5'"!="." | "`_label6'"!="Immer"){
			noisily: di as error "Error in Test 5 opendf read: Value Labels not correct."
			local error_occured5="TRUE"
		}
		
		local error_occured5="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		opendf read "Datasets Testscripts\data.zip", rowrange(10:) colrange(:5) clear

		
		if(c(N) != 11 | c(k)!=5) {
			noisily: di as error "Error in Test 5 opendf read: Dataset dimensions not correct."
			local error_occured5="TRUE"
		}
		
		local error_occured5="FALSE"
		shell rmdir "$output_folder" /s /q
		mkdir "$output_folder"
		opendf read "Datasets Testscripts\data.zip", rowrange(10:15) colrange(3:6) clear

		
		if(c(N) != 6 | c(k)!=4) {
			noisily: di as error "Error in Test 5 opendf read: Dataset dimensions not correct."
			local error_occured5="TRUE"
		}
		
		
		shell rmdir "$output_folder" /s /q

		mkdir "$output_folder"

	}

	

	********Display if all tests were sucessful

	
	if("`error_occured1'" =="FALSE" & "`error_occured2'" =="FALSE" & "`error_occured3'" =="FALSE" & "`error_occured4'" =="FALSE" & "`error_occured5'" =="FALSE"){
		di "Test opendf read successful."
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
	}
end
