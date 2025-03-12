net install opendf, from (https://opendataformat.github.io/stata-package-opendf/) replace


*in case of a update, this avoids errors (deletes functions from cache)
capture program drop opendf_csv2dta
capture program drop opendf_zip2csv
capture program drop opendf_read
capture program drop opendf_docu
capture program drop opendf_write
capture program drop opendf_csv2zip
capture program drop opendf_dta2csv
capture program drop opendf_installpython
capture program drop opendf

*set working directory to folder containing a subfolder with the testscripts and the subfolder containing the datasets for the testscripts
cd "C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\stata-package_from_github\Tests opendf package"
*cd "C:\Users\User\OneDrive - DIW Berlin\Open Data Format Project\Stata\Testscripts"
global output_folder "C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\stata-package_from_github\Tests opendf package\Output Testscripts"
*global output_folder "C:\Users\User\OneDrive - DIW Berlin\Open Data Format Project\Stata\Testscripts\Output Testscripts"
*Ensure Output testscripts folder is empty
shell rmdir "$output_folder" /s /q
mkdir "$output_folder"
global verbose = 1

capture program drop test_opendf_installremovepython
qui: do "Testscripts/test opendf installpython removepython.do"
capture program drop test_opendf_write
qui: do "Testscripts/test opendf write.do"
capture program drop test_opendf_read
qui: do "Testscripts/test opendf read.do"
capture program drop test_opendf_read_and_write
qui: do "Testscripts/test opendf read and write.do"
capture program drop test_opendf_docu
qui: do "Testscripts/test opendf docu.do"

test_opendf_docu
test_opendf_installremovepython
test_opendf_write
test_opendf_read
test_opendf_read_and_write


