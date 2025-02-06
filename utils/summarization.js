// utils/summarization.js
const {
  GoogleGenerativeAI,
} = require("@google/generative-ai");
const { GEMINI_API_KEY } = require("../config/config");

const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);

// Example model, considering whether to use hugging face model itself
const gemini_model = genAI.getGenerativeModel({
  model: "gemini-2.0-flash-thinking-exp-01-21",
});

const generationConfig = {
  temperature: 0.7,
  topP: 0.95,
  topK: 64,
  maxOutputTokens: 65536,
  responseMimeType: "text/plain",
};

async function summarizeTranscript(transcript) {
  if (!transcript || transcript.trim().length < 30) {
    return "No medical consultation found in the transcript";
  }

  try {
    const chatSession = gemini_model.startChat({ generationConfig });
    const prompt = `
      You are an assistant that extracts key medical information from a conversation transcript between a doctor and a patient. 
      
      Please analyze the following transcript and provide a JSON object with these fields:
      
      - "summary": ...
      ...
      
      If it's not a medical consultation, return "No medical consultation found in the transcript".

      Transcript:
      ${transcript}
    `;

    const response = await chatSession.sendMessage(prompt);
    const text = await response.response.text();
    return text;
  } catch (error) {
    console.error("Error in summarizeTranscript:", error);
    throw error;
  }
}

module.exports = {
  summarizeTranscript,
};
