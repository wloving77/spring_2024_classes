'''
Main file for configuring the network and running the simulator.
'''

import network_simulator

# Network 0
#
#    
# E0 
# | \    
# |  \   
# |7  \2 
# |    \ 
# |     \
# E2 --- E1
#     1
#
network0 = [
	[(1, 2), (2, 7)],         # E0
	[(0, 2), (2, 1)],         # E1
	[(0, 7), (1, 1 )],        # E2
]

simulator = network_simulator.NetworkSimulator(network0, 499, 3)
simulator.run()
simulator.display_forwarding_table(0)
simulator.display_forwarding_table(1)
simulator.display_forwarding_table(2)
print(simulator.route_packet(0, 2))
print("Running ....") if input("Run next Simulation Y/N ") == "Y" else exit 

#######################################################################
# EXPECTED RESULT
#######################################################################
# 
# E0 | Cost | Next Hop
# ---+------+---------
# 0  |    0 |        0
# 1  |    2 |        1
# 2  |    3 |        1
# E1 | Cost | Next Hop
# ---+------+---------
# 0  |    2 |        0
# 1  |    0 |        1
# 2  |    1 |        2
# E2 | Cost | Next Hop
# ---+------+---------
# 0  |    3 |        1
# 1  |    1 |        1
# 2  |    0 |        2



# Network 1
#
#    1
# E0 --- E1
# | \    |
# |  \   |
# |7  \3 | 1
# |    \ |
# |     \|
# E3 --- E2
#     2
#
network1 = [
	[(1, 1), (2, 3), (3, 7)], # E0
	[(0, 1), (2, 1)],         # E1
	[(0, 3), (1, 1), (3, 2)], # E2
	[(0, 7), (2, 2)],         # E3
]

# Create a new simulation with `network1`, a random seed value of 499, and
# debugging level 3.
simulator = network_simulator.NetworkSimulator(network1, 499, 3)

# Actually run the simulator. This will return when the lowest cost routes are
# found.
simulator.run()

# Print the forwarding table for each entity.
simulator.display_forwarding_table(0)
simulator.display_forwarding_table(1)
simulator.display_forwarding_table(2)
simulator.display_forwarding_table(3)

# Print the route a packet would take from entity 0 to entity 3.
print(simulator.route_packet(0, 3))
print("Running ....") if input("Run next Simulation Y/N ") == "Y" else exit 


#######################################################################
# EXPECTED RESULT
#######################################################################
# E0 | Cost | Next Hop
# ---+------+---------
# 0  |    0 |        0
# 1  |    1 |        1
# 2  |    2 |        1
# 3  |    4 |        1
# E1 | Cost | Next Hop
# ---+------+---------
# 0  |    1 |        0
# 1  |    0 |        1
# 2  |    1 |        2
# 3  |    3 |        2
# E2 | Cost | Next Hop
# ---+------+---------
# 0  |    2 |        1
# 1  |    1 |        1
# 2  |    0 |        2
# 3  |    2 |        3
# E3 | Cost | Next Hop
# ---+------+---------
# 0  |    4 |        2
# 1  |    3 |        2
# 2  |    2 |        2
# 3  |    0 |        3
# [0, 1, 2, 3]
#



# Network 2
#
#     1      2
# E0 --- E1 --- E2
# | \    |      |
# |  \5  |3     |1
# |   \  |      |
# |3   \-E3     E4
# |            /
# E5 ---------/
#          8
#
network2 = [
	[(1, 1), (3, 5), (5, 3)], # E0
	[(0, 1), (2, 2), (3, 3)], # E1
	[(1, 2), (4, 1)],         # E2
	[(0, 5), (1, 3)],         # E3
	[(2, 1), (5, 8)],         # E4
	[(0, 3), (4, 8)],         # E5
]


# Create a new simulation with `network2`, a random seed value of 499, and
# debugging level 3.
simulator = network_simulator.NetworkSimulator(network2, 499, 3)

# Actually run the simulator. This will return when the lowest cost routes are
# found.
simulator.run()

# Print the forwarding table for each entity.
simulator.display_forwarding_table(0)
simulator.display_forwarding_table(1)
simulator.display_forwarding_table(2)
simulator.display_forwarding_table(3)
simulator.display_forwarding_table(4)
simulator.display_forwarding_table(5)

# Print the route a packet would take from entity 0 to entity 5.
print(simulator.route_packet(0, 5))
print("Running ....") if input("Run next Simulation Y/N ") == "Y" else exit 


#######################################################################
# EXPECTED RESULT
#######################################################################
# E0 | Cost | Next Hop
# ---+------+---------
# 0  |    0 |        0
# 1  |    1 |        1
# 2  |    3 |        1
# 3  |    4 |        1
# 4  |    4 |        1
# 5  |    3 |        5
# E1 | Cost | Next Hop
# ---+------+---------
# 0  |    1 |        0
# 1  |    0 |        1
# 2  |    2 |        2
# 3  |    3 |        3
# 4  |    3 |        2
# 5  |    4 |        0
# E2 | Cost | Next Hop
# ---+------+---------
# 0  |    3 |        1
# 1  |    2 |        1
# 2  |    0 |        2
# 3  |    5 |        1
# 4  |    1 |        4
# 5  |    6 |        1
# E3 | Cost | Next Hop
# ---+------+---------
# 0  |    4 |        1
# 1  |    3 |        1
# 2  |    5 |        1
# 3  |    0 |        3
# 4  |    6 |        1
# 5  |    7 |        1
# E4 | Cost | Next Hop
# ---+------+---------
# 0  |    4 |        2
# 1  |    3 |        2
# 2  |    1 |        2
# 3  |    6 |        2
# 4  |    0 |        4
# 5  |    7 |        2
# E5 | Cost | Next Hop
# ---+------+---------
# 0  |    3 |        0
# 1  |    4 |        0
# 2  |    6 |        0
# 3  |    7 |        0
# 4  |    7 |        0
# 5  |    0 |        5



