##Date 26/01/2024

#grep, grepl, -->identification
#sub, gsub --> replacement
#(g)regexpr, regmatches --> extract

#strsplit()


#apropos() browseEnv(), help.search(), list.files(), ls



x1<- c('abc123', '123abc', '567klm', 'lml567', '123', 'abc', 'ABC123', '132ABC')

#extend regx

grepl('[a-z]\\d', x1)
grep('[a-z]\\d', x1)
grep('[a-z]\\d', x1, value = TRUE)

grepl('[a-zaA-Z]\\d', x1)

grep('[a-zaA-Z]\\d', x1, value = TRUE)

grep('(?i)[a-zaA-Z]\\d', x1, value = TRUE)  ##here (?i) means ignore case 

#by using + and *
 
grep('[a-zaA-Z]+\\d+', x1, value = TRUE)  #here number hona chhaiye kisi mein bhi

# "abc123" "lml567" "ABC123"

grep('[a-zaA-Z]*\\d*', x1, value = TRUE) #ere * means atleast number hona chahiye

# [1] "abc123" "123abc" "567klm" "lml567" "123"   
# [6] "abc"    "ABC123" "132ABC"


x2<- c('abc     123 ', ' 123abc', '567klm  ', '  lml567', '123  ', '  abc', 'ABC123  ', '132ABC')

#Q. find the where is space start and then come with number
#space follwed by number
grep('\\s\\d', x2, value = TRUE)
# [1] " 123abc"

grep('\\s+\\d+', x2, value = TRUE)

# [1] " 123abc"
# [1] "abc     123 " " 123abc"  

grep('\\s*\\d+', x2, value = TRUE)

# [1] "abc     123 " " 123abc"      "567klm  "    
# [4] "  lml567"     "123  "        "ABC123  "    
# [7] "132ABC" 



#### replace method regular expression

#sub()

string <- c("vinay bijalwan")

sub('\\s', '', string)

#remove space between two words
# [1] "vinaybijalwan"


#now change small 'a' letter to capital 'A'

sub('a', 'A', string)

# 1] "vinAy bijalwan"

#it only change starting 'a' letter to Capital 'A' letter not all

#for all change we can global sub()

gsub('a', 'A', string)

# [1] "vinAy bijAlwAn"   # it all change of all letter here




x4 <- c('abc123', 'abc8990', '?(1', '*2', '2')
#extarct number from string
gsub('\\D', '', x4)

# [1] "123"  "8990" "1"    "2"   

#extarct only alphabet
gsub('\\d', '', x4)

# [1] "abc" "abc" "?("  "*" 


#Q. put seprator b/t text and digit

# here we use capturing ()

gsub('(\\d+)', '/\\1', x4)

# [1] "abc/123"  "abc/8990" "?(/1"     "*/2"


# in this we use capturing () here (\\d+) capturing digit number and 
# save this to '\\1' and '/' put it

##if we use two capturing () () then it save \\1 and \\2 

gsub('(\\D)(\\d+)', '/\\1\\2', x4)

# [1] "ab/c123"  "ab/c8990" "?/(1"     "/*2" 

# here (\\D) capturing   not digit means capture character and save it as \\1
# (\\d+) capture digit number 

gsub('(\\D)(\\d+)', '\\1/\\2', x4)

#[1] "abc/123"  "abc/8990" "?(/1"     "*/2" 
#here \\1 capture (\\D) - not a digit this and \\2 capture (\\d+) -- digit 

## this give result
#[1] "abc/123"  "abc/8990" "?(/1"     "*/2"

# + and * -- greddy 
# ? -- stop the greedyness 
##gsub/sub

## in this example when we use 

gsub('(\\w+)(\\d)', '\\2/\\1', x4) #this wring way to tackle 

# [1] "3/abc12"  "0/abc899" "?(1"     
# [4] "*2" 

#her we use \\w which is only for word not special char
# second id \\w+ because \\w+ take char and more char
# and if we take . insted of +
gsub('(.+)(\\d+)', '\\2/\\1', x4) #wring way
#this give result 
#tab rukga jb atkleast ek number bacha rhe
#[1] "3/abc12"  "0/abc899" "1/?("    
# [4] "2/*"

# * is zero or more 
# + one plus 
#here to tell the .+ to stop if find any number
#then we use ? this
#because + and * are gtrrdy that till match jabtak kar sakte hai.
# * goes last match and + match one plus

#now stop greedyness we use ?

gsub('(.+?)(\\d+)', '\\2/\\1', x4)

#This give result 

# [1] "123/abc"  "8990/abc" "1/?("    
# [4] "2/*"

## jaise hi number mila na, main ruk jau

gsub('(.+?)(\\d+)', '\\1/\\2', x4)

# [1] "abc/123"  "abc/8990" "?(/1"    
# [4] "*/2"  


#if in regular expression want to upcase 
#letter , we can't do in normal regular expression

#\\U - for upcase letter

gsub('(.+?)(\\d+)', '\\U\\1/\\2', x4)

#result look like this
# [1] "Uabc/123"  "Uabc/8990" "U?(/1"    
# [4]

# for that use perl compaitable 


gsub('(.+?)(\\d+)', '\\U\\1/\\2', x4, perl = TRUE)

## now result is ok 
# [1] "ABC/123"  "ABC/8990" "?(/1"     "*/2"


# let go to next example

x5 <- c('mama', 'mamu', 'chachu', 'papa')
# Q. find the string where two char repeat like in mama, ma and ma - repeat her

# \\w and rhen repeat second word \\w and save it \\1 and second in \\2
grepl('(\\w)(\\w)(\\1\\2)', x5)

# [1]  TRUE FALSE FALSE  TRUE

grepl('(\\w)(\\w)(\\1\\2)', x5)


## ? use in non capturing
## ? lookaround 




##### new Topic 

## gregexpr and regmatches ## extract 

x6 <- c('xyzABC', 'AX2uB', 'BXXno2Y')

## here extract capital letter from X6

g <- gregexpr('[A-Z]+', x6)

g
# [[1]]  ## in this 1st match 
# [1] 4    ## found start with 4 index number
# attr(,"match.length")
# [1] 3  ## length of match is 3
# attr(,"index.type")
# [1] "chars"
# attr(,"useBytes")
# [1] TRUE
# 
# [[2]]  ## 2nd string 
# [1] 1 5 ## index 1 to 5
# attr(,"match.length")
# [1] 2 1  
# attr(,"index.type")
# [1] "chars"
# attr(,"useBytes")
# [1] TRUE
# 
# [[3]]
# [1] 1 7
# attr(,"match.length")
# [1] 3 1
# attr(,"index.type")
# [1] "chars"
# attr(,"useBytes")
# [1] TRUE

r <- regmatches(x6, g)
r

## this are extart capital letter from data

# [[1]]
# [1] "ABC"
# 
# [[2]]
# [1] "AX" "B" 
# 
# [[3]]
# [1] "BXX" "Y"  



####################################

#if want to replace Special char of regular expression like +, *, ? and many more

#then either use \\ or use []

x7 <- '+-'
#here replace + sign with - sign
gsub('+', '-', x7)
## it give this type ==> [1] "-+---"

#for that  we can use [] or \\

gsub('\\+', '-', x7)
## give correct answer ==> [1] "--"

##and can use []
gsub('[+]', '-', x7)
#This also give correct way to solve this
#[1] "--"


### next example 
x8 <- c('abc1234', 'fgafda89765')
#Q. spilt number and char

g <- gsub('([a-zA-Z])(\\d+)', '\\1-\\2', x8)

g

## This give result 
# "abc-1234"     "fgafda-89765"

## now split char and number

strsplit(g, split = '-')

## this give result

# [[1]]
# [1] "abc"  "1234"
# 
# [[2]]
# [1] "fgafda" "89765"

## now finally we seprate number and char


#### apropos() search all data type, function, data set
apropos('car')

# [1] ".GenericArgsEnv"          
# [2] ".rs.showHelpTopicArgument"
# [3] "cars"                     
# [4] "mtcars" 


## want that function with start with %

apropos("^%")

# 1] "%%"   "%*%"  "%/%"  "%in%" "%o%" 
# [6] "%x%"

help.search('mean$')
list.files()



### lookaround - zero widht assertion

## which is not digest any thing (ye kuch nhi kahte hai)

## look around move bi direction

##there is 4 types of look around

# 1. positive Look ahead  -- right direction
# 2. Negative Look ahead

# 3. positive Look behind
# 4. Negative Look behind

## here is one example 

## 5676667
## 7676658

##now we find that number which before three six

## in first number there is 5676667 (7) is that number  which three six before


## presence of any condition is positive , in this three 666 is positive 

## absent of condition negative look 

##next how ro write 

## look ahead and look behind alway with (?= )

## (?= ) --> Positive look ahead

## (?< = ) ---> Positive look behind

## (?! )  ---> Negative look ahead

##(?< !) ---> Negative Look behinnd


## now let work with example


x9 <- c('5689666890', '89667890', '666890')

##find that number jiske age 3, six ho
## right side mein three six chahiye then use postive look ahead --> (?= )
grepl('(?= 6{3} )', x9)

# Error in grepl("(?= 6{3} )", x9) : 
#   invalid regular expression '(?= 6{3} )', reason 'Invalid regexp'
# In addition: Warning message:
#   In grepl("(?= 6{3} )", x9) : TRE pattern compilation error 'Invalid regexp


## because in look around mien perl compatible hota hai
## it give error beacuse this is not normal regular expression

## then we use perl =True

grepl('(?=6{3})', x9, perl = TRUE)

#[1]  TRUE FALSE  TRUE

## atleast one number before triple six, we use \\d

grepl('\\d(?=6{3})', x9, perl = TRUE)

# [1]  TRUE FALSE FALSE

# here  third number give us false beacuse there is no any number before six



### problem solution  part -01

x10 <- c(10, 12, 15, 17, 19, 22, 24, 29, 30)
##find the even number 



