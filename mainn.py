# Import necessary libraries
from flask import Flask, render_template, request
from chatgpt_handler import get_chatgpt_response

# Create the Flask app
app = Flask(__name__)

# Define routes
@app.route('/')
def home():
    return render_template('index.html')

@app.route('/get_response', methods=['POST'])
def get_response():
    user_input = request.form['user_input']
    chatgpt_response = get_chatgpt_response(user_input)

    return render_template('index.html', user_input=user_input, chatgpt_response=chatgpt_response)

# Run the app if executed as the main script
if __name__ == '__main__':
    app.run(debug=True)
