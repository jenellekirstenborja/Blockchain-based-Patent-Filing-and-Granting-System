[
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_IPC_Classification",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_applicant",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_inventors",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_title",
				"type": "string"
			}
		],
		"name": "applyForPatent",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint64",
				"name": "_applicationNumber",
				"type": "uint64"
			}
		],
		"name": "grantPatent",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "admin",
		"outputs": [
			{
				"internalType": "enum IntellectualPropertySystem.Role",
				"name": "",
				"type": "uint8"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint64",
				"name": "",
				"type": "uint64"
			}
		],
		"name": "appliedIndex",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "appliedPatents",
		"outputs": [
			{
				"internalType": "uint64",
				"name": "applicationNumber",
				"type": "uint64"
			},
			{
				"internalType": "uint64",
				"name": "patentNumber",
				"type": "uint64"
			},
			{
				"internalType": "uint256",
				"name": "applicationDate",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "publicationDate",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "IPC_Classification",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "applicant",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "inventors",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "title",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint64",
				"name": "_applicationNumber",
				"type": "uint64"
			}
		],
		"name": "checkGrantStatus",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "ctrApplicationNumber",
		"outputs": [
			{
				"internalType": "uint64",
				"name": "",
				"type": "uint64"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "ctrPatentNumber",
		"outputs": [
			{
				"internalType": "uint64",
				"name": "",
				"type": "uint64"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_account",
				"type": "address"
			}
		],
		"name": "getRole",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint64",
				"name": "",
				"type": "uint64"
			}
		],
		"name": "grantedIndex",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "grantedPatents",
		"outputs": [
			{
				"internalType": "uint64",
				"name": "applicationNumber",
				"type": "uint64"
			},
			{
				"internalType": "uint64",
				"name": "patentNumber",
				"type": "uint64"
			},
			{
				"internalType": "uint256",
				"name": "applicationDate",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "publicationDate",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "IPC_Classification",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "applicant",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "inventors",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "title",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bytes32",
				"name": "",
				"type": "bytes32"
			}
		],
		"name": "hasBeenApplied",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint64",
				"name": "",
				"type": "uint64"
			}
		],
		"name": "isPatentAppliedFor",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint64",
				"name": "",
				"type": "uint64"
			}
		],
		"name": "isPatentGranted",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "roles",
		"outputs": [
			{
				"internalType": "enum IntellectualPropertySystem.Role",
				"name": "",
				"type": "uint8"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint64",
				"name": "_applicationNumber",
				"type": "uint64"
			}
		],
		"name": "viewApplication",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint64",
						"name": "applicationNumber",
						"type": "uint64"
					},
					{
						"internalType": "uint64",
						"name": "patentNumber",
						"type": "uint64"
					},
					{
						"internalType": "uint256",
						"name": "applicationDate",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "publicationDate",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "IPC_Classification",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "applicant",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "inventors",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "title",
						"type": "string"
					}
				],
				"internalType": "struct IntellectualPropertySystem.Patent",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint64",
				"name": "_applicationNumber",
				"type": "uint64"
			}
		],
		"name": "viewPatent",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint64",
						"name": "applicationNumber",
						"type": "uint64"
					},
					{
						"internalType": "uint64",
						"name": "patentNumber",
						"type": "uint64"
					},
					{
						"internalType": "uint256",
						"name": "applicationDate",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "publicationDate",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "IPC_Classification",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "applicant",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "inventors",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "title",
						"type": "string"
					}
				],
				"internalType": "struct IntellectualPropertySystem.Patent",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]