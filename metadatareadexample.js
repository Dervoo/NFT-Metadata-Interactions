// First, get the token ID of the NFT you want to read metadata for
const tokenId = "...";

// Then, construct the token URI using the base URI and the token ID
const baseURI = "https://example.com/";
const tokenURI = baseURI + tokenId.toString() + ".json";

// Finally, make an HTTP request to the token URI and parse the response as a JSON object
fetch(tokenURI)
  .then((response) => response.json())
  .then((metadata) => {
    // Use the metadata to determine card statistics, etc.
    const attack = metadata.attack;
    const defense = metadata.defense;
    // ...
  });
