Feature: Test online calculator scenarios
	Scenario Outline: Two Value Operation
	Given Open chrome browser and start application
	When I enter following values and press = button
				|value1 	| <value1>	|	
				|operator 	| <operator>|	
				|value2 	| <value2>	|
	Then I should be able to see
				|expected 	| <expected>|
	Examples:
			| value1| value2| operator	| expected	|
			| 23	| 10	| *			| 230		|
			| 1 	| 1	 	| +			| 2			|
			| 20 	| 20	| -			| 0			|
			| 64 	| 8	 	| /			| 8			|
			| 1 	| 0.5 	| /			| 2			|

	Scenario Outline: Single Value Operation
	Given Open chrome browser and start application
	When I enter single value with operator only button
				|value1 	| <value1>	|	
				|operator 	| <operator>|	
	Then I should be able to see
				|expected 	| <expected>|
	Examples:
			| value1	| operator	| expected	|
			| 	4		|		R	| 2  		|
			| 	123123	|		C	| 0CE		|
			| 	2 		|		R	| 1.41421356|
			| 	10 		|		%	| 0.1		|
			| 	20		|		#	| -20		|

	Scenario Outline: Boundary Test - Two Value Operation
	Given Open chrome browser and start application
	When I enter following values and press = button
				|value1 	| <value1>	|	
				|operator 	| <operator>|	
				|value2 	| <value2>	|
	Then I should be able to see
				|expected 	| <expected>|
	Examples:
			| value1	   | value2		| operator	| expected	  |
			| 9999999999   | 9999999999	|		*	| 10e17		  |
			| 999999999	   | 111111111 	|		+	| 1.111111e9 |

	Scenario Outline: Boundary Test - Single Value Operation
	Given Open chrome browser and start application
	When I enter single value with operator only button
				|value1 	| <value1>	|	
				|operator 	| <operator>|	
	Then I should be able to see
				|expected 	| <expected>|
	Examples:
			| value1				| operator	| expected	 |
			| 999999999 			|		#	| -999999999 |
			| 0.99999999 			|		R	| 1 		 |
			| 1.123456789			|		=	| 1.12345678 |
			| 1,123456789			|		=	| 1.12345678 |
			| ADEFGHIJKLOPQSTUWXYZ 	|		=	| 0CE		 |
			| adefghijkloprstuwxyz 	|		=	| 0CE		 |
			| !@$^&()_;:<>?{}[]\	|		=	| 0CE		 |

	Scenario Outline: Error Handling Test
	Given Open chrome browser and start application
	When I enter a chain of input
				|input 		| <input>	|	
	Then I should be able to see
				|expected 	| <expected>|
	Examples:
			| input			   | expected|
			| 123+C123C1C-121= | 2  	 | 
			| 1/0=			   | Error 	 |
			| 023*010= 		   | 230     |
	
	Scenario Outline: Special and Complex calculation
	Given Open chrome browser and start application
	When I enter a chain of input
				|input 		| <input>	|	
	Then I should be able to see
				|expected 	| <expected>|
	Examples:
			| input				| expected	|
			| 	123+56C2-117=	| 8  		|
			| 	123123+256*3CC	| 0CE		|
			| 	123+56CC2+228=	| 230		|
			| 	010%			| 0.1		|
			| 	100*8%			| 8			|
			| 	8%*100			| 8			|

# KeyMapping - Missing 1/x :(
# sqrt | R
# MC | V
# M+ | B
# M- | N
# MR | M
# C  | C
# %  | %
# /  | /
# +  | +
# -  | -
# =  | =
# x  | *
# .  | .
# #  | -/+

