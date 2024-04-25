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
    handleSubmit() {
      // Exit when the form isn't valid
      if (!this.checkFormValidity()) {
        return
      }
      // Submit the form data (you can add your logic here)
      console.log('IPC Classification:', this.ipcClassification)
      console.log('Applicant:', this.applicant)
      console.log('Inventor:', this.inventor)
      console.log('Title:', this.title)
      // Hide the modal manually
      this.$nextTick(() => {
        this.$bvModal.hide('modal-prevent-closing')
      })
    },
  


    async connectWallet() {
      if (window.ethereum) {
        this.provider = new ethers.providers.Web3Provider(window.ethereum);
        const accounts = await this.provider.send("eth_requestAccounts", []);
        this.account = accounts[0];
        await this.createContractInstance(); // wait for contract instance creation
        await this.getRole(); // fetch role after contract instance is created
      } else {
        console.error("Metamask is not installed");
      }
    },
    async createContractInstance() {
      var contractAddress = "0x9D6b7f231915145682A3b74112fb52e8380e87D8";
      this.contract = new ethers.Contract(contractAddress, contractAbi);
      this.contract = this.contract.connect(this.provider);
    },
    // async submitForm() {
    //   try {
    //     const tx = await this.contract.applyForPatent(
    //       this.IPC_classification,
    //       this.applicant,
    //       this.inventor,
    //       this.title
    //     );
    //     await tx.wait();
    //     console.log("Transaction mined:", tx.hash);
    //   } catch (error) {
    //     console.error("Error submitting form:", error);
    //   }
    // },
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
  },
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

</style>
