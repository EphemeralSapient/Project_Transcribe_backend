// utils/summarization.js
const {
  GoogleGenerativeAI,
} = require("@google/generative-ai");
const OpenAI = require("openai");
const { GEMINI_API_KEY, OPENAI_API_KEY } = require("../config/config");

// Prompt
const promptPrefix = `
You are an assistant that extracts key medical information from a conversation transcript between a doctor and a patient. 

Please analyze the following transcript and provide a JSON object with the following fields:

- "summary": A concise summary of the consultation.
- "diagnosis": The diseases or conditions diagnosed.
- "symptoms": A list of symptoms described by the patient.
- "medications_prescribed": A list of medications prescribed, including dosage and frequency. [medication, dosage, frequency, duration, wrong_medication_probability]
- "tests_ordered": Any diagnostic tests ordered by the doctor.
- "follow_up_instructions": Any instructions given for follow-up.
- "allergies": Any allergies mentioned.
- "family_history": Any relevant family medical history.
- "lifestyle_recommendations": Any recommendations regarding lifestyle changes.

If the field is empty then don't include it in the JSON object.

And if the transcript does not contain tablet or diagnosis related then return 'No response from model'

No Hallucination: Do not generate or infer any details not explicitly mentioned in the transcript.

Medical Abbreviations: Ensure that prescribed medications are accurately identified, as they may be written in code names or abbreviations.

If medication is unclear in abbreviation, provide the full name of the medication.

Always expand the abbreviation to the full name of the medication and try to guess or infer it with known medical knowledge along with dosage.

If dosage is unknown, try to infer it from the medication in transcript or set wrong_medication_probability to 1.

So follow the above instructions at ALL cost! Remember to think whether given medication aligns with symptoms and patient history.

"wrong_medication_probability" is the probability of the medication being wrong. It should be a decimal number between 0 and 1. You give this value as speech to text transcript could be wrong,
In case of wrong, it is vital to notify doctor that this medication does not align with symptoms and patient history or allergies, or even extreme dosage. 
If probability is more than 0.5, add another field "wrong_medication_reason" with your reasoning why.

IF medication name is closer to what you know or similar to what you know, then you can provide the medication name on "alternative_suggestion".

This is REAL LIFE data, so please be careful with the information you provide and WARN doctor if wrong medication is given.

Important : Don't use \`\`\`json \`\`\` or any other markdown syntax in the response. Just return the JSON object.
Here is the transcript:

[TRANSCRIPT GOES HERE]
`;

// Initialize Google Gemini AI
const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);

// Initialize OpenAI
const openai = new OpenAI({
  baseURL: "https://api.groq.com/openai/v1",
  apiKey: OPENAI_API_KEY
});

// Example model, considering whether to use hugging face model itself
const gemini_model = genAI.getGenerativeModel({
  model: "gemini-2.0-flash-thinking-exp-01-21",
});

const geminiConfig = {
  temperature: 0.7,
  topP: 0.95,
  topK: 64,
  maxOutputTokens: 65536,
  responseMimeType: "application/json",
};

const openaiConfig = {
  temperature: 0,
  max_completion_tokens: 10000,
  top_p: 0.95,
  model: "deepseek-r1-distill-llama-70b",
  reasoning_format: "hidden",
};

async function summarizeTranscriptWithGemini(transcript) {
  try {
    const chatSession = gemini_model.startChat({ generationConfig: geminiConfig });
    const prompt = `
      ${promptPrefix}
      ${transcript}
    `;

    const response = await chatSession.sendMessage(prompt);
    const text = await response.response.text();
    return text;
  } catch (error) {
    console.error("Error in summarizeTranscriptWithGemini:", error);
    throw error;
  }
}

async function summarizeTranscriptWithOpenAI(transcript) {
  try {
    Prompt = `
      ${promptPrefix}
      ${transcript}
    `;

    const response = await openai.chat.completions.create({
      messages: [
        { role: "system", content: "Response should always be JSON"},
        { role: "user", content: Prompt }
      ],
      ...openaiConfig
    });

    return response.choices[0].message.content;
  } catch (error) {
    console.error("Error in summarizeTranscriptWithOpenAI:", error);
    throw error;
  }
}

async function summarizeTranscript(transcript, provider = "openai") {
  if (!transcript || transcript.trim().length < 30) {
    return "No medical consultation found in the transcript";
  }

  if (provider === "openai") {
    return summarizeTranscriptWithOpenAI(transcript);
  // biome-ignore lint/style/noUselessElse: Up to user to pick.
  } else {
    return summarizeTranscriptWithGemini(transcript);
  }
}

module.exports = {
  summarizeTranscript,
  summarizeTranscriptWithGemini,
  summarizeTranscriptWithOpenAI,
};