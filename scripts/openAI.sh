export OPENAI_API_KEY=$(pass openAI/acc_key)
export PINECONE_API_KEY=$(pass openAI/pinecone)

# Pertaining to specific scripts in local
alias cligpt="python3 ~/openAI/terminal_assistant.py"
alias chatgpt="python3 ~/openAI/chatGPT.py"