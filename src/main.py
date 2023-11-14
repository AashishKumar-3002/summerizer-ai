from transformers import pipeline

def load_context(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        context = file.read()
    return context

def main(file_path):
    context = f"{file_path}.vtt"

    while True:
        print("\nOptions:")
        print("1. Ask a question w/o time")
        print("2. Exit")
        print("3. ASK QUESTION with time")

        choice = input("Enter your choice (1/2/3): ")

        if choice == '1':
            model_name = "deepset/roberta-base-squad2"
            nlp = pipeline('question-answering', model=model_name, tokenizer=model_name)
            question = input("Ask your question: ")
            QA_input = {'question': question, 'context': context}
            res = nlp(QA_input)
            print("Answer:", res['answer'])

        elif choice == '2':
            print("Exiting...")
            break

        elif choice == '3':
            model_name = "mistralai/Mistral-7B-v0.1"
            nlp = pipeline("text-generation", model="mistralai/Mistral-7B-v0.1")
            file_path = input("Enter the path of the new VTT file: ")
            context = load_context(file_path)
            print("Context reloaded from the new file.")

        else:
            print("Invalid choice. Please enter 1, 2, or 3.")

if __name__ == "__main__":
    main()
