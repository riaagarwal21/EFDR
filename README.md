# EFDR
EFDR: Efficient data compression technique using Extended Frequency-Directed Run-Length Code. Segments data based on symbol frequency, applies run-length encoding, and uses adaptive dictionaries for high compression rates. Ideal for varied symbol distributions.

EFDR (Extended Functional Decompression and Reconstruction) is a data compression technique that extends traditional method ( FDR ) by encoding both runs of 0's and runs of 1's using a compact representation. By leveraging a lookup table to map run lengths to corresponding code words, EFDR efficiently compresses test data while preserving functional information, leading to reduced storage requirements and faster test application times in integrated circuit testing.



![image](https://github.com/user-attachments/assets/ff46ecbd-a465-4b1b-b959-c97df3e46fd0)



The EFDR (Extended Functional Decompression and Reconstruction) technique is a lossless compression method used in data decoding. It employs several components such as a K-bit counter for storing code word information, a log2 K-bit counter for counting bits in the code word tail, an SR-Latch for storing run types, an XOR gate for controlling output types, and an FSM (Finite State Machine) with nine states for managing the decoding process. This circuitry ensures accurate decoding and synchronization with the input data, making EFDR suitable for lossless data compression applications.

## Inputs

**bit_in:** This is a single-bit input that represents the current bit in the data stream.
  
**reset:** This is an active-high reset signal that initializes the state machine to state s0 when asserted.
  
**clk:** This is the clock signal that triggers the state transitions within the module.






## Outputs:

**s:** This output indicates a successful detection of a specific pattern (exact pattern depends on the state machine logic).

**r:** This output indicates an unsuccessful detection or a reset condition (exact meaning depends on the state machine logic).

**out:** This output serves as the primary output and represents the decoded data or a flag based on the detected pattern.

**v:** This output signifies a valid data condition (might be high during pattern detection and low otherwise).

**en:** This output can be used as an enable signal for other connected modules (exact functionality depends on the overall design).

**q:** This output holds the previous value of out.

**outf:** This output is the final output, potentially resulting from XORing q with out at the falling edge of the clock.

**count_in:** This is a 6-bit register that keeps track of a counter value during specific states.

**inc:** This is another 6-bit register that holds an increment value used in the decoding process.



## State Machine Behavior:

The state machine transitions through various states based on the current state, the value of bit_in, and potentially other internal conditions. Here's a simplified explanation of some key states:

**s0:** This is the initial state where the module starts upon reset or completion of a decoding cycle.

**s1:** This state represents the beginning of the expected pattern.

**s2:** This state can check the second bit in the pattern.

**s3 to s7:** These states involves counting bits or manipulating the count_in and inc values based on the bit sequence.

**s8:** This state can indicate an error condition or the end of an unsuccessful detection.

**s9:** This state signifies the successful detection of the entire pattern. 

## Usage

To get a local copy of the project, you can clone the repository using the below mentioned command:

      git clone https://github.com/riaagarwal21/EFDR

## Simulation Results

![image](https://github.com/user-attachments/assets/6d6d8a64-23ff-43ee-937f-2f56d70777e9)
![image](https://github.com/user-attachments/assets/8bf9818d-fbaf-49ec-813a-48c324f6e7fe)


