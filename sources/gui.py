#!/usr/bin/python3
import os
import PySimpleGUI as sg
import clips
import textwrap3

sg.theme('DarkGrey4')

layout = [
    [
        sg.Push(),
        sg.Column([
                    [sg.Text('Are you ready?', size=(100, None), key='question_label')],
                    [sg.HSep()],
                    [sg.Yes(key='start_button')]
                ], element_justification='c'),
        sg.Push()
    ],
    [sg.pin(sg.Radio('', key='ans0', group_id='radio', visible=False, enable_events=True, default=True), shrink=True)],
    [sg.pin(sg.Radio('', key='ans1', group_id='radio', visible=False, enable_events=True), shrink=True)],
    [sg.pin(sg.Radio('', key='ans2', group_id='radio', visible=False, enable_events=True), shrink=True)],
    [sg.pin(sg.Radio('', key='ans3', group_id='radio', visible=False, enable_events=True), shrink=True)],
    [sg.pin(sg.Radio('', key='ans4', group_id='radio', visible=False, enable_events=True), shrink=True)],
    [sg.pin(sg.Radio('', key='ans5', group_id='radio', visible=False, enable_events=True), shrink=True)],
    [sg.pin(sg.Radio('', key='ans6', group_id='radio', visible=False, enable_events=True), shrink=True)],
    [sg.pin(sg.Radio('', key='ans7', group_id='radio', visible=False, enable_events=True), shrink=True)],
    [sg.pin(sg.Radio('', key='ans8', group_id='radio', visible=False, enable_events=True), shrink=True)],
    [sg.pin(sg.Radio('', key='ans9', group_id='radio', visible=False, enable_events=True), shrink=True)],
    [
        sg.Push(),
        sg.pin(sg.Image('', key='finish_image', visible=False), shrink=True),
        sg.Push()
    ],
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
    string_assert = '(start)'

    env = clips.Environment()
    window = sg.Window('Can we date?', layout, size=(800, 600))

    env.load(os.path.dirname(__file__) + '/constructs.clp')
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
            window['next_button'].Update(visible=True)
            window['reset_button'].Update(visible=True)
            window['next_button'].click()
        # next question
        elif event == 'next_button':
            print('-------- NEXT QUESTION --------')
            print('Fact to be asserted: ', string_assert)
            env.assert_string(string_assert)
            env.run()

            # reset answers radio buttons
            for i in range(10):
                window[f'ans{i}'].Update(False, visible=False)
            
            # get string from question fact
            for f in env.facts():
                print('FACT:', f)
                if 'question' in str(f):
                    # get question based on the fact inserted
                    info = f.__getitem__(0).split(';')
                    print('QUESTION:', info)

                    # parse question
                    fact[0] = info[0]
                    n_of_answers = int(info[1])
                    question = info[2]
                    answers = info[3:3+n_of_answers]
                    answers_short = info[3+n_of_answers:]
                    fact[1] = answers_short[0]
                    string_assert = f'({fact[0]} {fact[1]})'

                    print(fact, n_of_answers, question, answers, answers_short, sep=" | ")

                    # update GUI
                    question_text = textwrap3.wrap(question, 80)
                    window['question_label'].Update('\n'.join(question_text))

                    for i in range(n_of_answers):
                        window[f'ans{i}'].Update(text=f'{answers[i]}', visible=True)
                    
                    window['next_button'].Update(visible=True)
                    window['ans0'].Update(True)
                    # retract only question fact
                    f.retract()
                if 'finish' in str(f):
                    message = f.__getitem__(0)

                    message = textwrap3.wrap(message, 80)
                    print('\n'.join(message))
                    window['question_label'].Update('\n'.join(message))

                    for i in range(n_of_answers):
                        window[f'ans{i}'].Update(text='', visible=False)
                    
                    window['next_button'].Update(visible=False)
                    
                    f.retract()
                if 'image' in str(f):
                    img = f.__getitem__(0)
                    window['finish_image'].Update(f'{os.path.dirname(__file__)}/img/{img}.png', visible=True)
        # reset system
        elif event == 'reset_button':
            # reset GUI
            window['question_label'].Update('Are you ready?')
            window['start_button'].Update(visible=True)
            window['next_button'].Update(visible=False)
            window['reset_button'].Update(visible=False)
            window['finish_image'].Update('', visible=False)
            string_assert = '(start)'

            for i in range(10):
                window[f'ans{i}'].Update(text='', visible=False)
            
            # reset CLIPS
            env.reset()
        
        # change assert string based on choosen answer 
        for i in range(n_of_answers):
            if event == f'ans{i}':
                fact[1] = answers_short[i]
                string_assert = f'({fact[0]} {fact[1]})'

    window.close()
