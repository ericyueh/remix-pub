<html>
    <body>
        <h1>This is my dApp!</h1>
        <p>Here we can set or get the mood:</p>
        <label for="mood">Input Mood:</label> <br />
        <input type="text" id="mood" />
        <div>
            <button onclick="getMood()">Get Mood</button>
        </div>
        <div>
            <button onclick="setMood()">Set Mood</button>
        </div>
    </body>
    <script
       src="https://cdn.ethers.io/lib/ethers-5.2.umd.min.js"
       type="application/javascript"
    ></script>
    <script>
        window.ethereum.enable();
        var provider = new ethers.providers.Web3Provider(
            web3.currentProvider,
            "goerli"
        );
        var MoodContractAddress = "0xce0409944Cd2b52BF87cDA8f113963bCa38bCBED";
        var MoodContractABI = [
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_mood",
				"type": "string"
			}
		],
		"name": "setMood",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getMood",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
] ;
        var MoodContract;
        var signer;
        provider.listAccounts().then(function (accounts) {
          signer = provider.getSigner(accounts[0]);
          MoodContract = new ethers.Contract(
           MoodContractAddress,
           MoodContractABI,
           signer
         );
        });
        async function getMood() {
          getMoodPromise = MoodContract.getMood();
          var Mood = await getMoodPromise;
          console.log(Mood);
        }
        async function setMood() {
          let mood = document.getElementById("mood").value;
          setMoodPromise = MoodContract.setMood(mood);
          await setMoodPromise;
        }
    </script>
</html>
