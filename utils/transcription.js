// utils/transcription.js
const fs = require("fs");
const { HfInference } = require("@huggingface/inference");
const { HUGGING_FACE_TOKEN } = require("../config/config");

const hf = new HfInference(HUGGING_FACE_TOKEN);
const HF_MODEL = "openai/whisper-large-v3";

async function automaticSpeechRecognition(filePath) {
  const fileBuffer = fs.readFileSync(filePath);
  const transcription = await hf.automaticSpeechRecognition({
    data: fileBuffer,
    model: HF_MODEL,
  });
  return transcription.text; 
}

module.exports = {
  automaticSpeechRecognition,
};
