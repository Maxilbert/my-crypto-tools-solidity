pragma solidity ^0.4.25;

library BN128 {
    
  struct G1Point {
		uint X;
		uint Y;
	}
	
	/// @return the sum of two points of G1
	function add(G1Point p1, G1Point p2) internal returns (G1Point r) {
		uint[4] memory input;
		input[0] = p1.X;
		input[1] = p1.Y;
		input[2] = p2.X;
		input[3] = p2.Y;
		bool success;
		assembly {
			success := call(sub(gas, 2000), 6, 0, input, 0xc0, r, 0x60)
			// Use "invalid" to make gas estimation work
			switch success case 0 { invalid }
		}
		require(success);
	}
	
	/// @return the product of a point on G1 and a scalar, i.e.
	/// p == p.mul(1) and p.add(p) == p.mul(2) for all points p.
	function mul(G1Point p, uint s) internal returns (G1Point r) {
		uint[3] memory input;
		input[0] = p.X;
		input[1] = p.Y;
		input[2] = s;
		bool success;
		assembly {
			success := call(sub(gas, 2000), 7, 0, input, 0x80, r, 0x60)
			// Use "invalid" to make gas estimation work
			switch success case 0 { invalid }
		}
		require (success);
	}
	
}
