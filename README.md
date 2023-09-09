# Approximating MEV Boost Performance for mevETH


>**Note**    
> Disclaimer: NO FINANCIAL ADVICE 

    The Information on this Post is provided
    for education and informational purposes only, without any express or implied
    warranty of any kind, including warranties of accuracy, completeness, or
    fitness for any particular purpose. The Information contained in or provided
    from or through this application/website is not intended to be and does not constitute
    financial advice, investment advice, trading advice or any other advice. The
    Information on this application/website and provided from or through this service is
    general in nature and is not specific to you the User or anyone else. You
    should not make any decision, financial, investment, trading or otherwise,
    based on any of the information presented on this website without undertaking
    independent due diligence and consultation with a professional broker or
    financial advisory.


>**Warning**     
> This is a vastly simplified model to articulate an initial benchmark extrapolation without consideration for multi-block MEV, certain additional protocol related rewards, and only using data
from one day's worth of blocks to use values. A more accurate model would have sampled more than just one day's worth of block rewards.

### Assumptions 

No change in active validator set or total staked eth over the given time period

For a given validator, (its effective balance) / (total staked eth) is a good estimate of block proposal opportunity PER BLOCK. This appears to be true. (Further thoughts:) Within the ETH2 phase 0 specification, when searching for a block's proposer, a shuffled list of active validators is iterated through. Each validator's effective balance influences the chances of that validator being chosen. But, the effective balances of the other validators are important as well because if you are at shuffled position X, validator at (shuffled) index say X minus 5's chances of being chosen as also influenced by that validator's effective balance.

 If a validator before you in the shuffled index is chosen, you would not be considered. In simulations, I find (its effective balance) / (total staked eth) to provide a reasonable estimate of a validator's chance of being chosen to propose any given block. If all active validators have equal (say 32 eth) effective balance, then this simplifies to 1/(total active validators). But the latter would not attempt to account for the rest of the validators' effective balance's influence directly and indirectly on a given validator's chances.

Price of ETH in USD: 1634.63

Staking Fee = 7.000000000000001 %
Network Stake= 24960000

Reference Calculator: https://beaconcha.in/calculator
Data used provided by: https://flashbots-data.s3.us-east-2.amazonaws.com/index.html

    2.47 MB  2023-05-08T13:36:59.000Z  block-summary/daily/block_data_may_7_2023.csv     

    SHA256SUM: faff26b8e1132f3fc0356894a2068c127693a4e8042755ccae28ae5b849c3c22

## Overview

We take a block data and extrapolate based on  blocks rewards the breakdown of MEV rewards for Validators.

We break down MEV rewards into  two categories: 

- "Big Lottery" That is the reward probability of an amount of MEV rewards at most one a day.
- "Little Lottery" That is the reward probability of an amount of MEV Rewards with a similar probability of the total amount of validators in the staking pool's hourly probability of creating a block (i.e. proposing).


## Calculation

Note that one epoch has a duration of 12*32 seconds so there are:
86,400 seconds in a day 
225 epochs in a day:
6750 epochs every 30 days.
7,200 Blocks Per Day 


29.39% per hour
98.44% every 12 hours

3,060 Blocks per year (WCS)
2,592 (Worst that Worst Case)

### Non MEV Rewards (ETH2 Protocol Rewards, Simplified)
Nb Validators Median	Median   APY Average	Average APY
780,000	      1.2332	 3.85%	 1.52	        4.75%

Average occurrences: ≈ 228.43
Minimum occurrences: 188
Maximum occurrences: 271
Median occurrences: 229
WSC occurrences: 255

24960000 ≈ 20.40 %
27534119.899005


32.34268189
0.1847672284

7,113

### Big Lottery Blocks
Big Lottery Blocks = 1 a day

276 = 2.134182044 ETH
0.03888888888 %
Average occurrences: ≈ 28.00
Minimum occurrences: 7
Maximum occurrences: 60
Median occurrences: 28
This means that, with this adjusted hourly probability, you can expect the event to occur about 28 times over a 30-day period, based on our simulations. The observed occurrences in the simulations ranged from a minimum of 7 to a maximum of 60.


#### Little Lottery Blocks

Little Lottery Blocks = 7 a day

For Blocks with over > 0.3 ETH 
2,139 Blocks
1,509 ETH Total
0.70546984572 AVG

2139 = 0.70546984572 AVG ETH
2139 per day is 0.30071699704 %
Average occurrences: ≈ 216.52
Minimum occurrences: 155
Maximum occurrences: 282
Median occurrences: 216
With this adjusted hourly probability, we can expect the event to occur, on average, about 216 to 217 times over a 30-day period based on our simulations. The observed occurrences in the simulations ranged from a minimum of 155 to a maximum of 282.


## Summary

> ~ 0.140 ETH Per Block on Average WCS-ish


| Duration | ETH Stake                       | ETH Reward                  | Return       | Return in % |
|----------|---------------------------------|-----------------------------|--------------|-------------|
| Day      | 28802.4412 ETH ($4 7081 334.51) | 2.4412 ETH ($3 990.51)      | $3 206.27    | 0.01 %      |


| Week     | 28817.0870 ETH ($4 7105 274.88) | 17.0870 ETH ($27 930.88)    | $22 441.46   | 0.05 %      |
| Month    | 28875.6421 ETH ($4 7200 990.87) | 75.6421 ETH ($123 646.87)   | $99 340.11   | 0.21 %      |
| Year     | 29685.7724 ETH ($4 8525 254.06) | 885.7724 ETH ($1447 910.06) | $1162 314.68 | 2.47 %      |

| Per Day | Simulated Occurrence on Average per Day (monthly) | Monthly MEV Boost Guesstimate |
| ---: | ---: | ---: | ---: |
| Big Lottery 2.134182044 | 1 | 64.02546132 |
| Little Lottery 0.7054698457 | 7 | 148.1486676 |
|  |  | 212.1741289 |
|  | Simulated Monthly | 2546.089547 |


4,161,914.356 USD ETH in MEV