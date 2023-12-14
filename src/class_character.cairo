#[starknet::contract]
mod Class_Character {
    use starknet::{get_caller_address, ContractAddress};

    #[derive(Drop, Serde, starknet::Store)]
    struct StudentStruct {
        name: felt252,
        age: u8,
        is_active: bool,
        has_reward: bool,
        reward_balance: u8,
    }

    #[storage]
    struct Storage {
        student_map: LegacyMap<ContractAddress, StudentStruct>
    }

    // this function saves data to a LegacyMap given an address and a studentStruct instance 
    #[external(v0)]
    fn set_class_character(
        ref self: ContractState,
        _address: ContractAddress,
        _name: felt252,
        _age: u8,
        _is_active: bool,
        _has_reward: bool,
        _reward_balance: u8,
        _is_owing: bool
    ) {
        let mut student = StudentStruct {
            name: _name,
            age: _age,
            is_active: _is_active,
            has_reward: _has_reward,
            reward_balance: _reward_balance
        };

        self.student_map.write(_address, student);
    }

    // this function reads data from a LegacyMap in storage called student_map when passed an address as key
    #[external(v0)]
    fn get_class_character(self: @ContractState, _address: ContractAddress) -> StudentStruct {
        self.student_map.read(_address)
    }
}
