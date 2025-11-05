<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="qus.aspx.cs" Inherits="goWheel.qus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step-by-Step Survey</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        /* Custom styles for radio buttons */
        .form-check-input {
            position: absolute;
            top: 0;
            left: 0;
            z-index: 1;
            opacity: 0;
        }

        .form-check-label {
            position: relative;
            padding-left: 30px;
            cursor: pointer;
        }

        .form-check-input:checked + .form-check-label {
            color: #28a745;
        }

        .form-check-input:checked + .form-check-label::before {
            border-color: #28a745;
            background-color: #28a745;
        }

        .form-check-label::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            border: 2px solid #28a745;
            background-color: #fff;
            transition: all 0.3s;
        }

        .form-check-input:checked + .form-check-label::after {
            content: '';
            position: absolute;
            top: 6px;
            left: 6px;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: white;
        }

        /* Modal customizations */
        .modal-dialog {
            max-width: 500px;
        }

        .modal-header {
            background-color: #28a745;
            color: white;
            text-align: center;
            border-radius: 10px 10px 0 0;
        }

        .modal-footer {
            text-align: center;
        }

        .modal-footer .btn {
            width: 150px;
            font-size: 16px;
            border-radius: 25px;
        }

        .modal-footer .btn-primary {
            background-color: #28a745;
            border-radius: 25px;
        }

        .modal-footer .btn-primary:hover {
            background-color: #218838;
        }

        .modal-footer .btn-success {
            background-color: #218838;
            border-radius: 25px;
        }

        .modal-footer .btn-success:hover {
            background-color: #1e7e34;
        }

        /* General styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .modal-content {
            border-radius: 15px;
        }

        .modal-body {
            padding: 20px;
        }

        .form-check {
            margin-bottom: 10px;
        }

    </style>
</head>
<body>

<!-- Placeholder for Modals -->
<div id="modalContainer"></div>

<script>
    // Option model
    class OptionModel {
        constructor(optionId, text) {
            this.optionId = optionId;
            this.text = text;
        }
    }

    // Question model
    class QuestionModel {
        constructor(questionId, questionText, options) {
            this.questionId = questionId;
            this.questionText = questionText;
            this.options = options;
        }
    }

    // Questions related to bike use and pollution reduction
    const questions = [
        new QuestionModel(1, "What is your usual mode of transport?", [
            new OptionModel(1, "Bicycle"),
            new OptionModel(2, "Car"),
            new OptionModel(3, "Bus"),
            new OptionModel(4, "Walking")
        ]),
        new QuestionModel(2, "How often do you use your bicycle?", [
            new OptionModel(1, "Daily"),
            new OptionModel(2, "A few times a week"),
            new OptionModel(3, "Occasionally"),
            new OptionModel(4, "Rarely")
        ]),
        new QuestionModel(3, "What type of fuel does your car use?", [
            new OptionModel(1, "Petrol"),
            new OptionModel(2, "Diesel"),
            new OptionModel(3, "Electric"),
            new OptionModel(4, "Hybrid")
        ]),
        new QuestionModel(4, "On average, how much time do you spend on a bicycle per day?", [
            new OptionModel(1, "Less than 30 minutes"),
            new OptionModel(2, "30-60 minutes"),
            new OptionModel(3, "1-2 hours"),
            new OptionModel(4, "More than 2 hours")
        ]),
        new QuestionModel(5, "On average, how much time do you spend in a car per day?", [
            new OptionModel(1, "Less than 30 minutes"),
            new OptionModel(2, "30-60 minutes"),
            new OptionModel(3, "1-2 hours"),
            new OptionModel(4, "More than 2 hours")
        ]),
        new QuestionModel(6, "What is your usual bike ride distance?", [
            new OptionModel(1, "Less than 5 km"),
            new OptionModel(2, "5-10 km"),
            new OptionModel(3, "10-20 km"),
            new OptionModel(4, "More than 20 km")
        ]),
        new QuestionModel(7, "Do you actively choose to reduce car usage to help the environment?", [
            new OptionModel(1, "Yes, always"),
            new OptionModel(2, "Sometimes"),
            new OptionModel(3, "Not really"),
            new OptionModel(4, "Never")
        ])
    ];

    let userAnswers = [];

    // Render each question in its own modal
    $(document).ready(function () {
        const modalContainer = $("#modalContainer");

        questions.forEach((q, index) => {
            const isLast = index === questions.length - 1;
            let modalId = `modalQ${q.questionId}`;
            let nextModalId = index < questions.length - 1 ? `modalQ${questions[index + 1].questionId}` : "";

            let modalHTML = `
                <div class="modal fade" id="${modalId}" tabindex="-1" role="dialog" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title">Question ${q.questionId}</h5>
                      </div>
                      <div class="modal-body">
                        <p><strong>${q.questionText}</strong></p>
                        ${q.options.map(opt => `
                          <div class="form-check">
                              <input class="form-check-input" type="radio" name="q${q.questionId}" value="${opt.text}" id="q${q.questionId}_opt${opt.optionId}">
                              <label class="form-check-label" for="q${q.questionId}_opt${opt.optionId}">${opt.text}</label>
                          </div>`).join("")}
                      </div>
                      <div class="modal-footer">
                        ${isLast
                    ? `<button class="btn btn-success" onclick="submitAnswers()">Submit</button>`
                    : `<button class="btn btn-primary" onclick="goToModal('${modalId}', '${nextModalId}')">Next</button>`
                }
                      </div>
                    </div>
                  </div>
                </div>
            `;

            modalContainer.append(modalHTML);
        });

        // Show the first modal
        $(`#modalQ1`).modal('show');
    });

    // Show next modal
    function goToModal(currentId, nextId) {
        $(`#${currentId}`).modal('hide');
        setTimeout(() => {
            $(`#${nextId}`).modal('show');
        }, 300);
    }

    // Submit function to collect answers
    function submitAnswers() {
        let answers = {};
        questions.forEach(q => {
            let val = $(`input[name='q${q.questionId}']:checked`).val();
            answers[`Question ${q.questionId}`] = val || "No answer";
            userAnswers.push(val);
        });

        console.log("Survey Answers:", answers);

        // Redirect to dashboard.aspx after submission
        window.location.href = "dashboard.aspx"; // Redirect to dashboard page
    }
</script>

</body>
</html>