#!/usr/bin/python3

import PySimpleGUI as sg
import clips
import textwrap

sg.theme('DarkGrey4')

layout = [
    [
        sg.Push(),
        sg.Column([
                    [sg.Text('Are you ready?', size=(40, None), key='question_label')],
                    [sg.HSep()],
                    [sg.Yes(key='start_button')]
                ], element_justification='c'),
        sg.Push()
    ],
    [sg.Radio('', key='ans0', group_id='radio', visible=False, enable_events=True, default=True)],
    [sg.Radio('', key='ans1', group_id='radio', visible=False, enable_events=True)],
    [sg.Radio('', key='ans2', group_id='radio', visible=False, enable_events=True)],
    [sg.Radio('', key='ans3', group_id='radio', visible=False, enable_events=True)],
    [sg.Radio('', key='ans4', group_id='radio', visible=False, enable_events=True)],
    [sg.Radio('', key='ans5', group_id='radio', visible=False, enable_events=True)],
    [sg.Radio('', key='ans6', group_id='radio', visible=False, enable_events=True)],
    [sg.Radio('', key='ans7', group_id='radio', visible=False, enable_events=True)],
    [sg.Radio('', key='ans8', group_id='radio', visible=False, enable_events=True)],
    [sg.Radio('', key='ans9', group_id='radio', visible=False, enable_events=True)],
    [
        sg.Push(),
        sg.Column([[sg.Button('Next', key='next_button', visible=False)]], element_justification='c'),
        sg.Push()
    ],
    [
        sg.Push(),
        sg.Column([[sg.Button('Reset', key='reset_button', visible=False)]], element_justification='c'),
        sg.Push()
    ]
]


if __name__ == '__main__':
    fact = ['', '']         # fact to be asserted
    question = ''           # question text
    n_of_answers = 0        # number of answers
    answers = []            # answers list
    answer_short = []       # answers in short format

    env = clips.Environment()
    window = sg.Window('Can we date?', layout, size=(1000, 500))

    env.load('constructs.clp')
    env.assert_string('(start)')

    while True:
        event, values = window.read()
        print(event)

        # close window
        if event == sg.WIN_CLOSED or event == 'Cancel':
            break
        # start system
        elif event == 'start_button':
            window['start_button'].Update(visible=False)
            # run start rule with first question
            env.run()
            for f in env.facts():
                # get string from question fact
                info = f.__getitem__(0).split(';')
                print('INFO:', info)
                if 'question' in str(f):
                    fact[0] = info[0]
                    n_of_answers = int(info[1])
                    question = info[2]
                    answers = info[3:3 + n_of_answers]
                    answers_short = info[3 + n_of_answers:]

                    print(fact, n_of_answers, question, answers, answers_short, sep=" | ")

                    question_text = textwrap.wrap(question, 100)
                    window['question_label'].Update(question_text[0])

                    for i in range(n_of_answers):
                        window[f'ans{i}'].Update(text=f'{answers[i]}', visible=True)
                    f.retract()
            window['next_button'].Update(visible=True)
            window['reset_button'].Update(visible=True)
            fact[1] = answers_short[0]
            string_assert = f'({fact[0]} {fact[1]})'
            print('Fact to be asserted: ', string_assert)

        # change assert string based on choosen answer 
        for i in range(n_of_answers):
            if event == f'ans{i}':
                fact[1] = answers_short[i]
                string_assert = f'({fact[0]} {fact[1]})'
        
        if event == 'next_button':
            print('-------- NEXT QUESTION --------')
            for i in range(10):
                window[f'ans{i}'].Update(False, visible=False)

            print('Fact to be asserted: ', string_assert)
            env.assert_string(string_assert)
            env.run()

            for f in env.facts():
                # get string from question fact
                info = f.__getitem__(0).split(';')
                print('INFO:', info, f)
                if 'question' in str(f):
                    fact[0] = info[0]
                    n_of_answers = int(info[1])
                    question = info[2]
                    answers = info[3:3+n_of_answers]
                    answers_short = info[3+n_of_answers:]

                    print(fact, n_of_answers, question, answers, answers_short, sep=" | ")

                    question_text = textwrap.wrap(question, 100)
                    window['question_label'].Update(question_text[0])

                    for i in range(n_of_answers):
                        window[f'ans{i}'].Update(text=f'{answers[i]}', visible=True)

                    f.retract()

            window['ans0'].Update(True)
            window['next_button'].Update(visible=True)
            fact[1] = answers_short[0]
            string_assert = f'({fact[0]} {fact[1]})'
        elif event == 'reset_button':
            window['question_label'].Update('Are you ready?')
            window['start_button'].Update(visible=True)
            window['next_button'].Update(visible=False)
            window['reset_button'].Update(visible=False)

            for i in range(10):
                window[f'ans{i}'].Update(text='', visible=False)
            
            env.reset()

    window.close()
