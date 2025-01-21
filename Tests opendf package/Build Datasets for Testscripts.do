

cd "C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Testscripts\Datasets Testscripts"


net install opendf, from (https://opendataformat.github.io/stata-package-opendf/) replace


opendf read "C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Testscripts\Datasets Testscripts\data.zip", clear save(testdata) replace
opendf read "C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Testscripts\Datasets Testscripts\data_with_missings.zip", clear save(testdata_with_missings) replace
opendf read "C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Testscripts\Datasets Testscripts\data_with_default.zip", clear save(testdata_with_default) replace

*csv2xml, output("C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Datasets Testscripts\testdata") input("C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Datasets Testscripts\csv")
*csv2dta, csv_loc("C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Datasets Testscripts\testdata") save(testdata) clear replace
*csv2xml, output("C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Datasets Testscripts\testdata with default language") input("C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Datasets Testscripts\csv_default")
*csv2dta, csv_loc("C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Datasets Testscripts\testdata with default languages csvs") save(testdata_with_default_language) clear replace
*csv2xml, output("C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Datasets Testscripts\testdata with missings") input("C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Datasets Testscripts\csv_with_missings")
*csv2dta, csv_loc("C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Datasets Testscripts\testdata with missings csvs") save(testdata_with_missings) clear replace


use "C:\Users\thartl\OneDrive - DIW Berlin\Open Data Format Project\Stata\Testscripts\Datasets Testscripts\testdata", clear