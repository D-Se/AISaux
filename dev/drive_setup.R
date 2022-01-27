# googlesheets4::gs4_auth(email = "2869830202@qq.com")
# 
# box::use(g = googlesheets4)
# 
# x = g$gs4_find("2869830202@qq.com")
# 
# x = googlesheets4::gs4_find()
# 
# 
# g$gs4_get(x)

options(gargle_oauth_cache = ".secrets")
# check the value of the option, if you like
gargle::gargle_oauth_cache()
# trigger auth on purpose to store a token in the specified cache
# a broswer will be opened
googlesheets4::gs4_auth()
# see your token file in the cache, if you like
list.files(".secrets/")

# sheets reauth with specified token and email address
googlesheets4::gs4_auth(
  cache = ".secrets",
  email = "2869830202@qq.com"
)

tt <- googlesheets4::gs4_get("1FveHRUUPTN2yuMh4CTkXxrxlzhXgOKXpbQ6eyCUnv9E")

