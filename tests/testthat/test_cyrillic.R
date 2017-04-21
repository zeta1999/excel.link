context("cyrillic encoding")


options(excel.link.fix_encoding = TRUE)

xl[a1] = "������" 

expect_identical(xl[a1], "������")
xl[a1] = NA

tab  = readRDS("rds/cro_real1.rds")

xlrc[a1] = tab
new_tab = cr[a3]
expect_equal_to_reference(new_tab, "rds/cyrillic_1.rds")

xl.workbook.close()
xlr[a1] = list(tab, tab, tab)
new_tab = cr[a1]

expect_equal_to_reference(new_tab, "rds/cyrillic_2.rds")

xl.workbook.close()
xl.write(tab, xl()$Range("a1"), remove_repeated = FALSE)
new_tab = cr[a3]

expect_equal_to_reference(new_tab, "rds/cyrillic_3.rds")


xl.workbook.close()
xl.write(list(tab, tab, tab), xl()$Range("a1"), remove_repeated = FALSE)
new_tab = cr[a3]

expect_equal_to_reference(new_tab, "rds/cyrillic_4.rds")

xl.workbook.close()
colnames(tab)[1] = "��� ����� ���"
xlrc[a1] = tab
new_tab = cr[a3]

expect_equal_to_reference(new_tab, "rds/cyrillic_5.rds")
xl.workbook.close()
options(excel.link.fix_encoding = FALSE)