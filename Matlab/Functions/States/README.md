# STATE functions


A `state` should reduce to a Boolean true or false condition.  
For example, a given observational **Price** either is or isn't less than a calculated **Moving Average** value:  
> Logically: Observational Price < Moving Average =?= **TRUE** || **FALSE**    

A `state` output should produce one of two outputs:

| Signal Output | Boolean |
| ------------- | ------- |
|0|**False**|
|1|**True**|

By using one or more conditional evaluations, we are able to create a desired `signal` based on desired logic.

**FUNDAMENTAL CONSIDERATIONS:**

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!! STATES MAY OR MAY NOT REPEAT PER OBSERVATION !!!!
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!    SIGNALS SHOULD BE CLEAN AND NOT REPEAT    !!!!
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Revision:		4937.18944  
