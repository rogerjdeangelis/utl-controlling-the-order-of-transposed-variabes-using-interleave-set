                                                                                                                  
SAS Forum: Controlling the order of transposed variabes using interleave set                                      
                                                                                                                  
Good Question Thanks                                                                                              
                                                                                                                  
The hard part of this problem was ordering the transpose output                                                   
                                                                                                                  
You do not need a slow double transpose, or a sort/merge.                                                         
                                                                                                                  
                                                                                                                  
github                                                                                                            
http://tinyurl.com/y68ysb2y                                                                                       
https://github.com/rogerjdeangelis/utl-controlling-the-order-of-transposed-variables-using-interleave-set         
                                                                                                                  
SAS Forum                                                                                                         
https://communities.sas.com/t5/SAS-Programming/complex-transpose/m-p/569686                                       
                                                                                                                  
                                                                                                                  
*_                   _                                                                                            
(_)_ __  _ __  _   _| |_                                                                                          
| | '_ \| '_ \| | | | __|                                                                                         
| | | | | |_) | |_| | |_                                                                                          
|_|_| |_| .__/ \__,_|\__|                                                                                         
        |_|                                                                                                       
;                                                                                                                 
                                                                                                                  
I added weight.                                                                                                   
                                                                                                                  
                                                                                                                  
data have;                                                                                                        
   input Location$ Date$ NAME$ Measurement$;                                                                      
cards4;                                                                                                           
ColePond 02JUN95 Length1 31                                                                                       
ColePond 02JUN95 Length2 32                                                                                       
ColePond 02JUN95 Length3 32                                                                                       
ColePond 02JUN95 Length4 33                                                                                       
ColePond 02JUN95 Weight1 63                                                                                       
ColePond 02JUN95 Weight2 64                                                                                       
ColePond 02JUN95 Weight3 67                                                                                       
ColePond 02JUN95 Weight4 62                                                                                       
EagleLak 02JUN95 Length1 32                                                                                       
EagleLak 02JUN95 Length2 32                                                                                       
EagleLak 02JUN95 Length3 33                                                                                       
EagleLak 02JUN95 Length4 .                                                                                        
EagleLak 02JUN95 Weight1 70                                                                                       
EagleLak 02JUN95 Weight2 76                                                                                       
EagleLak 02JUN95 Weight3 .                                                                                        
EagleLak 02JUN95 Weight4 .                                                                                        
;;;;                                                                                                              
run;quit;                                                                                                         
                                                                                                                  
                                                                                                                  
WORK.HAVE total obs=16                                                                                            
                                                                                                                  
  LOCATION     DATE       NAME      MEASUREMENT                                                                   
                                                                                                                  
  ColePond    02JUN95    Length1        31                                                                        
  ColePond    02JUN95    Length2        32                                                                        
  ColePond    02JUN95    Length3        32                                                                        
  ColePond    02JUN95    Length4        33                                                                        
                                                                                                                  
  ColePond    02JUN95    Weight1        63                                                                        
  ColePond    02JUN95    Weight2        64                                                                        
  ColePond    02JUN95    Weight3        67                                                                        
  ColePond    02JUN95    Weight4        62                                                                        
                                                                                                                  
  EagleLak    02JUN95    Length1        32                                                                        
  EagleLak    02JUN95    Length2        32                                                                        
  EagleLak    02JUN95    Length3        33                                                                        
                                                                                                                  
  EagleLak    02JUN95    Length4                                                                                  
  EagleLak    02JUN95    Weight1        70                                                                        
  EagleLak    02JUN95    Weight2        76                                                                        
  EagleLak    02JUN95    Weight3                                                                                  
  EagleLak    02JUN95    Weight4                                                                                  
                                                                                                                  
*            _               _                                                                                    
  ___  _   _| |_ _ __  _   _| |_                                                                                  
 / _ \| | | | __| '_ \| | | | __|                                                                                 
| (_) | |_| | |_| |_) | |_| | |_                                                                                  
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                 
                |_|                                                                                               
;                                                                                                                 
                                                                                                                  
                                                                                                                  
NOTE ALTERNATING LENGHT AND WEIGHT                                                                                
                                                                                                                  
                                                                                                                  
WORK.WANT total obs=2                                                                                             
                                                                                                                  
 LOCATION     DATE      LENGTH1    WEIGHT1    LENGTH2    WEIGHT2    LENGTH3    WEIGHT3    LENGTH4    WEIGHT4      
                                                                                                                  
 ColePond    02JUN95      31         63         32         64         32         67         33         62         
 EagleLak    02JUN95      32         70         32         76         33                                          
                                                                                                                  
*                                                                                                                 
 _ __  _ __ ___   ___ ___  ___ ___                                                                                
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                               
| |_) | | | (_) | (_|  __/\__ \__ \                                                                               
| .__/|_|  \___/ \___\___||___/___/                                                                               
|_|                                                                                                               
;                                                                                                                 
                                                                                                                  
* interleave length and weight;                                                                                   
                                                                                                                  
data havAlternate/view=havAlternate                                                                               
                                                                                                                  
   set have(where=(name=:"L"));                                                                                   
   output;                                                                                                        
   set have(where=(name=:"W"));                                                                                   
   output;                                                                                                        
                                                                                                                  
run;quit;                                                                                                         
                                                                                                                  
* simple transpose;                                                                                               
proc transpose data=havAlt out=want(drop=_name_);                                                                 
  by location date;                                                                                               
  id name;                                                                                                        
  var measurement;                                                                                                
run;quit;                                                                                                         
                                                                                                                  
                                                                                                                  
                                                                                                                  
                                                                                          
