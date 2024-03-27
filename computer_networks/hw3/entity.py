'''
Code for an entity in the network. This is where you should implement the
distance-vector algorithm.
'''

from packet import Packet
import math

class Entity:
    '''
    Entity that represents a node in the network.

    Each function should be implemented so that the Entity can be instantiated
    multiple times and successfully run a distance-vector routing algorithm.
    '''

    def __init__(self, entity_index, number_entities):
        '''
        This initialization function will be called at the beginning of the
        simulation to setup all entities.

        Arguments:
        - `entity_index`:    The id of this entity.
        - `number_entities`: Number of total entities in the network.

        Return Value: None.
        '''
        # Save state
        self.index = entity_index
        self.number_of_entities = number_entities

        ''' initalize the matrix with values of inifinity
        '''
        # The 2D array distance vector table.
        # You will probably need to read and write to (update) this 2d array iteratively, throughout the whole process.
        self.distance_vector_table = [[math.inf for i in range(self.number_of_entities)] for j in range(self.number_of_entities)]  

        # Map of entity-to-cost for the neighbors of this entity.
        # In __init__, we set costs all to infinity. 
        # Note that you only need to update this map once in the "initialize_costs" method. After that, you only read from the map.
        self.neighbors_cost_map = {}
        for entity in range(0, number_entities):
            self.neighbors_cost_map[entity] = math.inf
            
        self.next_hop_table = {destination: None for destination in range(self.number_of_entities)}
        
            
        


    def initialize_costs(self, neighbor_costs):
        '''
        This function will be called at the beginning of the simulation to
        provide a list of neighbors and the costs on those one-hop links.

        Arguments:
        - `neighbor_costs`:  Array of (entity_index, cost) tuples for
                             one-hop neighbors of this entity in this network.

        Return Value: This function should return an array of `Packet`s to be
        sent from this entity (if any) to neighboring entities.
        Basically, use and return the "build_packet_array" method.
        '''
        
        self.distance_vector_table[self.index][self.index] = 0

        for neighbor, cost in neighbor_costs:
            
            if neighbor != self.index:
                
                self.next_hop_table[neighbor] = neighbor 
            
                self.neighbors_cost_map[neighbor] = cost
                
                self.distance_vector_table[self.index][neighbor] = cost
            
        
        return self.build_packet_array()
            

    def build_packet_array(self):
        '''
        This function should return an array of packets to be
        sent from this entity (if any) to neighboring entities. 

        Note that there is no need to send a packet to this entity itself.
        Also, there is no way to send a packet to an entity
        that is not a direct neighbor. 

        Return Value: This function should return an array of `Packet`s to be
        sent from this entity (if any) to neighboring entities.
        '''
        
        packets = []
        
        sender_distance_vector = self.distance_vector_table[self.index]
        
        #Loop over all neighbors
        for neighbor in self.neighbors_cost_map.keys():
            #check if the neighbor is directly connected (not infinity)
            if self.neighbors_cost_map[neighbor] < math.inf and neighbor!=self.index:
                packet = Packet(neighbor, sender_distance_vector)
                packets.append(packet)

        return packets


    def update(self, pkt):
        '''
        This function is called when a packet arrives for this entity.

        Arguments:
        - `packet`: The incoming packet of type `Packet`.

        Return Value: This function should return an array of `Packet`s to be
        sent from this entity (if any) to neighboring entities.
        '''
        
        #Bool to track if we actually updated anything
        updated = False
        
        source = pkt.get_source()
        received_costs = pkt.get_costs()
        
        for dest in range(self.number_of_entities):
            if dest != self.index:
                
                new_cost = self.neighbors_cost_map[source] + received_costs[dest]
                
                if new_cost < self.distance_vector_table[self.index][dest]:
                    self.distance_vector_table[self.index][dest] = new_cost
                    self.next_hop_table[dest] = source
                    print (f"dest {dest} -> next_hop {self.next_hop_table[dest]}")
                    updated=True
                    
        if updated:
            return self.build_packet_array()
        else:
            return []
        
        


    def forward_next_hop(self, destination):
        '''
        Return the best next hop for a packet with the given destination.

        Arguments:
        - `destination`: The final destination of the packet.

        Return Value: The index of the best neighboring entity to use as the
        next hop.
        '''
        
        if destination == self.index:
            return self.index
        
        return self.next_hop_table[destination]
                    
         

    def get_all_costs(self):
            '''
            This function is used by the simulator to retrieve the calculated routes
            and costs from an entity. This is most useful at the end of the
            simulation to collect the resulting routing state.

            Return Value: This function should return an array of (next_hop, cost)
            tuples for _every_ entity in the network based on the entity's current
            understanding of those costs. The array should be sorted such that the
            first element of the array is the next hop and cost to entity index 0,
            second element is to entity index 1, etc.
            '''
            array_of_tuples = []
            for index in range(0, self.number_of_entities): 
                next_hop = self.forward_next_hop(index)
                array_of_tuples.append((next_hop, self.distance_vector_table[self.index][index]))
            return array_of_tuples
