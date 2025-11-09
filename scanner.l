%{
/*
 * EaseCode Lexical Analyzer (Scanner)
 * Modified to meet output format: Line <n>: <TOKEN_TYPE> → <lexeme>
 * Identifier regex updated to match documentation.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *token_output;
FILE *error_log;

int line_num = 1;
int col_num = 1;
int error_count = 0;

void init_files();
void close_files();
void update_position(char *text);
void log_error(char *message, int line, int col, char ch);
%}

%option noyywrap

%%

\"[^\"]*\"              { 
                            fprintf(token_output, "Line %d: STRING → %s\n", line_num, yytext);
                            update_position(yytext);
                        }

/* Keywords */
"start"                 { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"finish"                { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"number"                { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"decimal"               { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"text"                  { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"show"                  { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"get"                   { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"check"                 { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"otherwise"             { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"loop"                  { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"nothing"               { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"giveback"              { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"yes"                   { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"no"                    { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"new"                   { 
                            fprintf(token_output, "Line %d: KEYWORD → %s\n", line_num, yytext);
                            update_position(yytext);
                        }

/* Literals (Float rule must come before Integer)  */
[0-9]+\.[0-9]+          { 
                            fprintf(token_output, "Line %d: FLOAT → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
[0-9]+                  { 
                            fprintf(token_output, "Line %d: INTEGER → %s\n", line_num, yytext);
                            update_position(yytext);
                        }

/* Identifier */

[a-zA-Z][a-zA-Z]* { 
                            fprintf(token_output, "Line %d: IDENTIFIER → %s\n", line_num, yytext);
                            update_position(yytext);
                        }

/* Operators */
"+"                     { 
                            fprintf(token_output, "Line %d: OPERATOR → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"-"                     { 
                            fprintf(token_output, "Line %d: OPERATOR → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"*"                     { 
                            fprintf(token_output, "Line %d: OPERATOR → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"="                     { 
                            fprintf(token_output, "Line %d: OPERATOR → %s\n", line_num, yytext);
                            update_position(yytext);
                        }

/* Punctuation*/
";"                     { 
                            fprintf(token_output, "Line %d: PUNCTUATION → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"("                     { 
                            fprintf(token_output, "Line %d: PUNCTUATION → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
")"                     { 
                            fprintf(token_output, "Line %d: PUNCTUATION → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"{"                     { 
                            fprintf(token_output, "Line %d: PUNCTUATION → %s\n", line_num, yytext);
                            update_position(yytext);
                        }
"}"                     { 
                            fprintf(token_output, "Line %d: PUNCTUATION → %s\n", line_num, yytext);
                            update_position(yytext);
                        }

/* Whitespace and Newlines */
[ \t]+                  { 
                            update_position(yytext); /* Ignore, just update column */
                        }
\n                      { 
                            line_num++;
                            col_num = 1;
                        }
\r                      { /* Ignore carriage return */ }

/* Error handling */
.                       { 
                            log_error("Invalid character", line_num, col_num, yytext[0]);
                            update_position(yytext);
                        }

%%

void init_files() {
    token_output = fopen("tokens.txt", "w");
    if (token_output == NULL) {
        fprintf(stderr, "Error: Cannot open tokens.txt for writing\n");
        exit(1);
    }
    
    error_log = fopen("error.log", "w");
    if (error_log == NULL) {
        fprintf(stderr, "Error: Cannot open error.log for writing\n");
        exit(1);
    }
}

void close_files() {
    if (token_output != NULL) {
        fflush(token_output);
        fclose(token_output);
        token_output = NULL;
    }
    if (error_log != NULL) {
        fflush(error_log);
        if (error_count == 0) {
            fclose(error_log);
            remove("error.log"); /* Delete error log if no errors */
        } else {
            fclose(error_log);
        }
        error_log = NULL;
    }
}


void update_position(char *text) {
    col_num += strlen(text);
}

void log_error(char *message, int line, int col, char ch) {
    if (error_log != NULL) {
        error_count++;
        if (ch == '\0') {
            fprintf(error_log, "Error at line %d, column %d: %s\n", line, col, message);
        } else {
            fprintf(error_log, "Error at line %d, column %d: %s '%c'\n", line, col, message, ch);
        }
        fflush(error_log);
    }
}

/* Main driver function */
int main(int argc, char *argv[]) {
    FILE *input_file = NULL;
    
    init_files();
    
    if (argc > 1) {
        input_file = fopen(argv[1], "r");
        if (input_file == NULL) {
            fprintf(stderr, "Error: Cannot open input file %s\n", argv[1]);
            close_files();
            return 1;
        }
        yyin = input_file;
        fprintf(stderr, "Scanning file: %s\n", argv[1]);
    } else {
        yyin = stdin;
        fprintf(stderr, "Scanning from stdin (press Ctrl+D to end input)\n");
    }
    
    if (token_output == NULL) {
        fprintf(stderr, "ERROR: token_output is NULL!\n");
        return 1;
    }
    
    fprintf(stderr, "Starting lexical analysis...\n");
    yylex();
    
    if (input_file != NULL) {
        fclose(input_file);
        input_file = NULL;
    }
    
    if (token_output != NULL) {
        fflush(token_output);
    }
    
    close_files();
    
    /* Check if tokens.txt was actually written to */
    FILE *check_file = fopen("tokens.txt", "r");
    if (check_file == NULL) {
        fprintf(stderr, "ERROR: tokens.txt was not created!\n");
        return 1;
    }
    
    fseek(check_file, 0, SEEK_END);
    long file_size = ftell(check_file);
    fclose(check_file);
    
    fprintf(stderr, "Lexical analysis completed.\n");
    if (file_size > 0) {
        fprintf(stderr, "Tokens written to: tokens.txt (%ld bytes)\n", file_size);
    } else {
        fprintf(stderr, "WARNING: tokens.txt is empty - no tokens were generated!\n");
    }
    
    if (error_count > 0) {
        fprintf(stderr, "Errors found: %d (see error.log)\n", error_count);
    } else {
        fprintf(stderr, "No errors found.\n");
    }
    
    /* Return success only if tokens were generated */
    return (file_size > 0) ? 0 : 1;
}