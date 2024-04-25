<template>
  <div id="app">
    <div class="container">
      <b-navbar toggleable="lg" type="" variant="" class="p-0">
        <b-navbar-brand class="text-dark" href="#">
          <p class="header">Intellectual Property Filing and Granting System</p>
        </b-navbar-brand>
        <b-navbar-nav class="ml-auto">
          <b-navbar-nav>
            <b-nav-item href="#" disabled v-if="role === 1">
              <p class="admin-text">Admin</p>
            </b-nav-item>

            <b-nav-item href="#" disabled v-else>
              <p class="user-text">User</p>
            </b-nav-item>
          </b-navbar-nav>
        </b-navbar-nav>
      </b-navbar>
    </div>
    <p class="account-text" v-if="account">Account Address: {{ account }}</p>
    <p class="bxv"> {{ pendingList }}</p>
    <b-button v-b-modal.modal-prevent-closing >Apply</b-button>
    
    <!-- Patent Application Form -->
    <b-modal
      id="modal-prevent-closing"
      ref="modal"
      title="Patent Application Form"
      @show="resetModal"
      @hidden="resetModal"
      @ok="handleOk"
    >
      <form ref="form" @submit.stop.prevent="handleSubmit">
        <b-form-group
          label="IPC Classification"
          label-for="ipc_classification"
          invalid-feedback="IPC Classification is required"
          :state="ipcClassificationState"
        >
          <b-form-input
            id="ipc_classification"
            v-model="ipcClassification"
            :state="ipcClassificationState"
            required
          ></b-form-input>
        </b-form-group>

        <b-form-group
          label="Applicant"
          label-for="applicant"
          invalid-feedback="Applicant is required"
          :state="applicantState"
        >
          <b-form-input
            id="applicant"
            v-model="applicant"
            :state="applicantState"
            required
          ></b-form-input>
        </b-form-group>

        <b-form-group
          label="Inventor"
          label-for="inventor"
          invalid-feedback="Inventor is required"
          :state="inventorState"
        >
          <b-form-input
            id="inventor"
            v-model="inventor"
            :state="inventorState"
            required
          ></b-form-input>
        </b-form-group>

        <b-form-group
          label="Title"
          label-for="title"
          invalid-feedback="Title is required"
          :state="titleState"
        >
          <b-form-input
            id="title"
            v-model="title"
            :state="titleState"
            required
          ></b-form-input>
        </b-form-group>
      </form>
    </b-modal>


  <!-- Table for Viewing Patent Applications -->
  <!-- <div class="p-2">
      <table>
        <thead>
          <tr v-for="headerGroup in table.getHeaderGroups()" :key="headerGroup.id">
            <th v-for="header in headerGroup.headers" :key="header.id" :colSpan="header.colSpan">
              <FlexRender
                v-if="!header.isPlaceholder"
                :render="header.column.columnDef.header"
                :props="header.getContext()"
              />
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="row in table.getRowModel().rows" :key="row.id">
            <td v-for="cell in row.getVisibleCells()" :key="cell.id">
              <FlexRender :render="cell.column.columnDef.cell" :props="cell.getContext()" />
            </td>
          </tr>
        </tbody>
        <tfoot>
          <tr v-for="footerGroup in table.getFooterGroups()" :key="footerGroup.id">
            <th v-for="header in footerGroup.headers" :key="header.id" :colSpan="header.colSpan">
              <FlexRender
                v-if="!header.isPlaceholder"
                :render="header.column.columnDef.footer"
                :props="header.getContext()"
              />
            </th>
          </tr>
        </tfoot>
      </table>
    </div> -->
    </div>
  
</template>



<script>


import { ethers } from "ethers";

import contractAbi from "../contracts-abi/ip.json";

export default {
  name: "ApplyForm",
  data() {
    return {
      provider: null,
      account: null,
      contract: null,
      role: null,

      ipcClassification: '',
      ipcClassificationState: null,
      applicant: '',
      applicantState: null,
      inventor: '',
      inventorState: null,
      title: '',
      titleState: null,

      table: null,
      pendingList: [],
      

  };
},
beforeMount() {
    this.connectWallet();
  },
  methods: {

    checkFormValidity() {
      const valid = this.$refs.form.checkValidity()
      this.ipcClassificationState = valid
      this.applicantState = valid
      this.inventorState = valid
      this.titleState = valid
      return valid
    },
    resetModal() {
      this.ipcClassification = ''
      this.ipcClassificationState = null
      this.applicant = ''
      this.applicantState = null
      this.inventor = ''
      this.inventorState = null
      this.title = ''
      this.titleState = null
    },
    handleOk(bvModalEvent) {
      // Prevent modal from closing
      bvModalEvent.preventDefault()
      // Trigger submit handler
      this.handleSubmit()
    },
    // handleSubmit() {
    //   // Exit when the form isn't valid
    //   if (!this.checkFormValidity()) {
    //     return
    //   }
    //   // Submit the form data (you can add your logic here)
    //   console.log('IPC Classification:', this.ipcClassification)
    //   console.log('Applicant:', this.applicant)
    //   console.log('Inventor:', this.inventor)
    //   console.log('Title:', this.title)
    //   // Hide the modal manually
    //   this.$nextTick(() => {
    //     this.$bvModal.hide('modal-prevent-closing')
    //   })
    async handleSubmit() {
  // Exit when the form isn't valid
  if (!this.checkFormValidity()) {
    return;
  }

  try {
    // Connect the contract with the signer
    var signer = this.provider.getSigner(); // signer - user's ethereum address
    var contractWithSigner = await this.contract.connect(signer);
    

    // Call the applyForPatent function on the smart contract
    var apply = await contractWithSigner.applyForPatent(
      this.ipcClassification,
      this.applicant,
      this.inventor,
      this.title
    );

    // Transaction successful, log the details
    console.log(apply, 'Transaction successful');
    
    // Hide the modal manually
    this.$nextTick(() => {
      this.$bvModal.hide('modal-prevent-closing');
    });
  } catch (error) {
    // Log and handle errors
    console.error('Error submitting patent application:', error);
    // Optionally, you can display an error message to the user
  }
},

  


    async connectWallet() {
      if (window.ethereum) {
        this.provider = new ethers.providers.Web3Provider(window.ethereum);
        const accounts = await this.provider.send("eth_requestAccounts", []);
        this.account = accounts[0];
        await this.createContractInstance(); 
        
        await this.getAllPendingLists();
        await this.getRole();
        
         // fetch role after contract instance is created
      } else {
        console.error("Metamask is not installed");
      }
    },
    async createContractInstance() {
      var contractAddress = "0x57b1281678D6A75C00275D181A4d4ab79DA76d48";
      this.contract = new ethers.Contract(contractAddress, contractAbi);
      this.contract = this.contract.connect(this.provider);
    },
    async getAllPendingLists() {
      this.appliedPatentsLength = await this.contract.getAllAppliedPatents();
      this.pendingList =[];
      for (let i = 0; i < this.appliedPatentsLength; i++) {
        var patent = await this.contract.appliedPatents(i)
        var _patent = {
          ipcClassification: patent.IPC_Classification,
      applicant: patent.applicant,
      inventor: patent.inventors,
      title: patent.title,
          

        }
        this.pendingList.push(_patent)
        console.log(this.pendingList);
      }
    },

    

        // Connect the contract with the signer
        
        
      


    

    async getRole() {
      try {
        // Get the signer
        const signer = this.provider.getSigner();
        // Connect the contract with the signer
        const contractWithSigner = await this.contract.connect(signer);
        // Get the role from the contract
        const role = await contractWithSigner.getRole(
          await signer.getAddress()
        );
        // Parse the role to an integer
        this.role = parseInt(role);
        // Log the role for debugging
        console.log("Role:", this.role);
      } catch (error) {
        console.error("Error getting role:", error);
      }
    },
  }
  
};

</script>

<style>
/* .apply-text {
  font-size: 
  letter-spacing: 1.5px;
  font-weight: bold;
  color: #ab9a91;
  text-transform: uppercase;

} */
.header {
  font-size: 1em;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: bold;
  color: #555;
}
.user-text {
  font-size: 1.1em;
  letter-spacing: 1.2px;
  font-weight: bold;
  color: #ab9a91;
}
.admin-text {
  font-size: 1.1em;
  letter-spacing: 1.2px;
  font-weight: bold;
  color: #d5bdaf;
}
.account-text {
  font-size: 1em;
  letter-spacing: 3px;
  color: #afb3a2;
}
form {
  max-width: 450px;
  margin: 30px auto;
  text-align: left;
  padding: 40px;
  border-radius: 10px;
}
label {
  color: #aaa;
  display: inline-block;
  margin: 25px 0 15px;
  font-size: 0.9em;
  text-transform: uppercase;
  letter-spacing: 2px;
  font-weight: bold;
}
input {
  display: block;
  padding: 10px 6px;
  width: 100%;
  box-sizing: border-box;
  border: none;
  border-bottom: 1px solid #ddd;
  color: #555;
}
.submit-button {
  background: #555; /* Updated button background color */
  border: 0;
  padding: 15px 30px; /* Adjusted padding */
  margin-top: 20px;
  color: white;
  border-radius: 40px;
  text-transform: uppercase;
  font-weight: bold; /* Added font weight */
  cursor: pointer; /* Added cursor style */
}
.submit {
  text-align: center;
}

table {
  border: 1px solid lightgray;
}

tbody {
  border-bottom: 1px solid lightgray;
}

th {
  border-bottom: 1px solid lightgray;
  border-right: 1px solid lightgray;
  padding: 2px 4px;
}

tfoot {
  color: gray;
}

tfoot th {
  font-weight: normal;
}


</style>
