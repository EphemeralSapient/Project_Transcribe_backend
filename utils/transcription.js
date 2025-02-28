// utils/transcription.js
const fs = require("node:fs");
const { HfInference } = require("@huggingface/inference");
const { HUGGING_FACE_TOKEN } = require("../config/config");

const { OPENAI_API_KEY } = require("../config/config");

const OpenAI = require("openai");
const openai = new OpenAI({
  baseURL: "https://api.groq.com/openai/v1",
  apiKey: OPENAI_API_KEY
});

const openaiConfig = {
  model: "openai/whisper-large-v3",
  language: "en",
}

const hf = new HfInference(HUGGING_FACE_TOKEN);
const HF_MODEL = "openai/whisper-large-v3";

async function openaiSpeechRecognition(filePath) {
  try {
    const transcription = await openai.audio.transcriptions.create({
      file: fs.readFileSync(filePath),
      ...openaiConfig,
    });
    return transcription.text;
  } catch (error) {
    console.error("Error transcribing with OpenAI:", error);
    throw error;
  }
}

async function automaticSpeechRecognition(filePath, provider = "hf") {

  if (provider === "openai") {
    return await openaiSpeechRecognition(filePath);
  // biome-ignore lint/style/noUselessElse: User preference
  } else {
    const fileBuffer = fs.readFileSync(filePath);
    const transcription = await hf.automaticSpeechRecognition({
      data: fileBuffer,
      model: HF_MODEL,
      parameters: {
        language: "en"
      }

    });
    return transcription.text;
  }
}

module.exports = {
  automaticSpeechRecognition,
};
