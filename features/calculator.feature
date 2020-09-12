Feature: Test online calculator scenarios
	Scenario Outline: Simple Two Value Operation
	Given Open chrome browser and start application
	When I enter following values and press = button
				|value1 	| <value1>	|	
				|operator 	| <operator>|	
				|value2 	| <value2>	|
	Then I should be able to see
				|expected 	| <expected>|
	Examples:
			| value1	| value2	| operator	| expected	|
			| 	23		|   10	 	|		*	| 230		|
			| 	1 		|   1	 	|		+	| 2			|
			| 	20 		|   20	 	|		-	| 0			|
			| 	64 		|   8	 	|		/	| 8			|

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

