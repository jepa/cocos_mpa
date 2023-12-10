# DBEM runs

## Tuna runs

Run: GFDL26
Scenario 1: C6GFDL26TUS1 20021034 Done
Scenario 2: C6GFDL26TUS2 20021406 Done
Scenario 3: C6GFDL26TUS3 20021626 Done

Run: GFDL85
Scenario 1: C6GFDL85TUS1 20021900 Done
Scenario 2: C6GFDL85TUS2 20022047 Done
Scenario 3: C6GFDL85TUS3 20022469 Done

Run: IPSL26 (compare with GFDL85 to male sure it was well ran)
Scenario 1: C6IPSL26TUS1 20022691 Done
Scenario 2: C6IPSL26TUS2 20022793 Done
Scenario 3: C6IPSL26TUS3 20023464 Done

Run: IPSL85
Scenario 1: C6IPSL85TUS1 20026851 Done
Scenario 2: C6IPSL85TUS2 20026986 Done
Scenario 3: C6IPSL85TUS3 20027147 Done

Run: MPIS26
Scenario 1: C6MPIS26TUS1 20032115 Done
Scenario 2: C6MPIS26TUS2 20034221 Done
Scenario 3: C6MPIS26TUS3 20034476 Done

Run: MPIS85
Scenario 1: C6MPIS85TUS1 20034980 Done
Scenario 2: C6MPIS85TUS2 20036786 # Needs to be re-run completely 
  - Second run: 20115655 
  - Third run: 20122261
Scenario 3: C6MPIS85TUS3 20037007 # Needs to be re-run completely (Timed out)
  - Second run: 20115686 - Faile, the weirdest error
  - Third run: 20122191

Converting from `.txt. to `.Rdata`
Run: 20072356 Done
Run: 20173691 for last two scenarios


## Runs for MPIS 2.6

### Scenario 3
*Date: 01/12/2023*
*Job: 19651289* - 

 SppNo           43
 CCSc C6MPI26
 SSP SSP126
 rsfile RunSppCocos
 rpath C6MPIS26F1MPAS3
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_3

### Scenario 2

*Date: 01/12/2023*
*Job: 19650592* - SOMETHING WENT WROGN

 SppNo           43
 CCSc C6MPI26
 SSP SSP126
 rsfile RunSppCocos
 rpath C6MPIS26F1MPAS2
 tpath TaxonDataC0
 ifile 11
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_2

### Scenario 1
*Date: 01/12/2023*
*Job: 19650129* - 

 SppNo           43
 CCSc C6MPI26
 SSP SSP126
 rsfile RunSppCocos
 rpath C6MPIS26F1MPAS1
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_1

## Runs for MPIS 5.5
### Scenario 3
*Date: 01/12/2023*
*Job: 19649672* - All good

 SppNo           43
 CCSc C6MPI85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6MPIS85F1MPAS3
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_3

### Scenario 2

*Date: 06/12/2023*
*Job: 19963069* - 

 SppNo           43
 CCSc C6MPI85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6MPIS85F1MPAS2
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_2

*Date: 01/12/2023*
*Job: 19648830* - Failed

SppNo           43
 CCSc C6MPI85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6MPIS85F1MPAS2
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_2

### Scenario 1

*Date: 01/12/2023*
*Job: 19648198* - 

 SppNo           43
 CCSc C6MPI85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6MPIS85F1MPAS1
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_1

## Runs for IPSL 2.6

### Scenario 3
*Date: 26/11/2023*
*Job: 19290901* - Job Wall-clock time: 1-04:02:53

  SppNo           43
 CCSc C6IPSL26
 SSP SSP126
 rsfile RunSppCocos
 rpath C6IPSL26F1MPAS3
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_3

*Date: 15/11/2023*
*Job: 18467483* (4 CPU-N) - Fail Node
 SppNo           43
 CCSc C6IPSL26
 SSP SSP126
 rsfile RunSppCocos
 rpath C6IPSL26F1MPAS3
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_3

### Scenario 2
*Date: 15/11/2023*
*Job: 18467179* (6 CPU) - Job Wall-clock time: 1-03:04:16

 SppNo           43
 CCSc C6IPSL26
 SSP SSP126
 rsfile RunSppCocos
 rpath C6IPSL26F1MPAS2
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_2

### Scenario 1
*Date: 15/11/2023*
*Job: 18467027* Job Wall-clock time: 1-00:58:07

 SppNo           43
 CCSc C6IPSL26
 SSP SSP126
 rsfile RunSppCocos
 rpath C6IPSL26F1MPAS1
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_1


## Runs for IPSL 8.5

### Scenario 3

*Date: 28/11/2023*
*Job: 19428632* 
SppNo           43
 CCSc C6IPSL85
 SSP SSP585
 rsfile	RunSppCocos
 rpath C6IPSL85F1MPAS3
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_3


 
### Scenario 2

*Date: 26/11/2023*
*Job: 19290428* - 

SppNo           43
 CCSc C6IPSL85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6IPSL85F1MPAS2
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_2


*Date: 15/11/2023*
*Job: 18470737* - Fail Node

SppNo           43
 CCSc C6IPSL85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6IPSL85F1MPAS2
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_2


### Scenario 1

*Date: 15/11/2023*
*Job: 18468638* Job Wall-clock time: 1-00:20:17

SppNo           43
 CCSc C6IPSL85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6IPSL85F1MPAS1
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_1

## Runs for GFDL 2.6

### Scenario 3
*Date: 15/11/2023*
*Job: 18466682* (4 CPU) - Job Wall-clock time: 1-00:47:37

SppNo           43
 CCSc C6GFDL26
 SSP SSP126
 rsfile RunSppCocos
 rpath C6GFDL26F1MPAS3
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_3


### Scenario 2
*Date: 15/11/2023*
*Job: 18465293* (2 CPU) - Job Wall-clock time: 1-02:00:26

 SppNo           43
 CCSc C6GFDL26
 SSP SSP126
 rsfile RunSppCocos
 rpath C6GFDL26F1MPAS2
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_2

### Scenario 1

*Date: 15/11/2023*
*Job: 18464547* (1 CPU) - Job Wall-clock time: 1-00:06:06

 SppNo           43
 CCSc C6GFDL26
 SSP SSP126
 rsfile RunSppCocos
 rpath C6GFDL26F1MPAS1
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_1

## Runs for GFDL 8.5 (COMPLETED)

### Scenario 3

*Date: 10/11/2023*
*Job: 18048756* - Successfull run

SppNo           43
 CCSc C6GFDL85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6GFDL85F1MPAS3
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_3


 *Date: 08/11/2023*
*Job: 17758698* - Problem with result ( MPA grid and F)

SppNo           43
 CCSc C6GFDL85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6GFDL85F1MPAS3
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_3


*Date: 25/10/2023*
*Job: 16315356* - Time ended 10 hrs 
*Job: 16428504* - Problem with result ( MPA grid and F)

 SppNo           43
 CCSc C6GFDL85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6GFDL85F1MPAS3
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_3
 
### Scenario 2

*Date: 10/11/2023*
*Job: 18048475* - Successfull run
                                               
 SppNo           43
 CCSc C6GFDL85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6GFDL85F1MPAS2
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_2

*Date: 12/10/23*
*Job: 17757128* - Problem with result ( MPA grid and F)

SppNo           43
 CCSc C6GFDL85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6GFDL85F1MPAS2
 tpath TaxonDataC0
 ifile 11
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_2

*Date: 25/10/2023*
*Job: 16315154* - Time ended 10 hrs 
*job: 16428711* - Problem on converting to R data
 
SppNo           43
 CCSc C6GFDL85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6GFDL85F1MPAS2
 tpath TaxonDataC0
 ifile 11
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_2
 
*Date: 12/10/23*
*Job: 14948959*

### Scenario 1

*Date: 08/11/23*
*Job: 17755707* - Successfull run

 SppNo           43
 CCSc C6GFDL85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6GFDL85F1MPAS1
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_1

*job:* - Problem result

SppNo           43
 CCSc C6GFDL85
 SSP SSP585
 rsfile RunSppCocos
 rpath C6GFDL85F1MPAS1
 tpath TaxonDataC0
 ifile 10
 FHS    1.00
 FEEZ    1.00
 MPApath cocos_1 
 

