/* Stephanie Pennington | Project 5*/
/* CMSC106 - Intro to C Programming */
/* This project implements a gradebook application to keep track of students and scores */

#include <stdio.h>
#include <string.h>
#include "gradebook.h"

static int check_null(Gradebook *g);

/*static function to print out invalid statement if NULL*/
static int check_null(Gradebook *g) {
  if (g == NULL) {
    return 1;
  }
  return 0;
}

/*initialize gradebook*/
int init_gradebook(Gradebook *g) {
  int i, j;
  /*NULL check*/
  if (check_null(g)) {
    printf("Invalid gradebook");
    return 0;
  }
  
  g->number_of_students = 0;
  g->number_of_assignments = 0;
  /*set all scores to 0*/
  for (i = 0; i < MAX_NUMBER_OF_STUDENTS; i++) {
    for (j = 0; j < MAX_NUMBER_OF_ASSIGNMENTS; j++) {
      g->scores[i][j] = 0;
    }
  }
  return 1;
}

/*add student to gradebook*/
int add_student(Gradebook *g, const char *name, const char *email) {
  int i;
  int end_index = g->number_of_students;
  /*NULL checks*/
  if (check_null(g)) {
    printf("Invalid gradebook");
    return 0;
  }
  if (name == NULL || email == NULL) {
    return 0;
  }
  /*check if student already exits*/
  for (i = 0; i < MAX_NUMBER_OF_STUDENTS; i++) {
    if (strcmp(g->students[i].name, name) == 0) {
      return 0;
    }
  }
  /*enter name and email into gradebook*/
  strcpy(g->students[end_index].name, name);
  strcpy(g->students[end_index].email, email);

  g->number_of_students++;
  return 1;
}

/*print out gradebook contents*/
int print_gradebook(Gradebook *g, int scores) {
  int i, j, k, l, avg;
  char name[] = "Name";
  char lg;
  /*NULL check*/
  if (check_null(g)) {
    printf("Invalid gradebook");
    return 0;
  }
  printf("****** Students ******\n");
  for (i = 0; i < g->number_of_students; i++) {
    printf("%s, %s \n", g->students[i].name, g->students[i].email);
  }

  if (scores != 0) {
    printf("****** Scores ******\n");
    printf("%-20s", name);
    /*print assignment names*/
    for (j = 0; j < g-> number_of_assignments; j++) {
      printf("%-5s", g->assignment_names[j]);
    }
    printf("AVG  LGR");
    printf("\n");
    /*print student name and associated grades*/
    for (l = 0; l < g->number_of_students; l++) {
      printf("%-20s", g->students[l].name);
      for (k = 0; k < g->number_of_assignments; k++) {
        printf("%-5d", g->scores[l][k]);
      }
      get_avg_and_letter_grade(g, g->students[l].name, &avg, &lg);
      printf("%-5d %-5c", avg, lg);
      printf("\n");
    }
  }
  return 1;
}

/*add assignment to gradebook*/
int add_assignment(Gradebook *g, const char *aName) {
  int i;
  /*NULL checks*/
  if (check_null(g)) {
    printf("Invalid gradebook");
    return 0;
  }
  if (aName == NULL || g->number_of_assignments >= MAX_NUMBER_OF_ASSIGNMENTS) {
    return 0;
  }
  /*check if assignment name already exists*/
  for (i = 0; i < g->number_of_assignments; i++) {
    if (strcmp(g->assignment_names[i], aName) == 0) {
      return 0;
    }
  }
  /*add new assignment to gradebook*/
  strcpy(g->assignment_names[g->number_of_assignments], aName);

  g->number_of_assignments++;
  return 1;
}

/*add score for specific stuednt and assignment*/
int set_assignment_score(Gradebook *g, const char *sName, const char *aName, const int score) {
  int i, j, indexS, indexA;
  /*NULL checks*/
  if (check_null(g)) {
    printf("Invalid gradebook");
    return 0;
  }
  if (sName == NULL || aName == NULL) {
    return 0;
  }
  /*find location of student name in array*/
  for (i = 0; i < MAX_NUMBER_OF_STUDENTS; i++) {
    if (strcmp(g->students[i].name, sName) == 0) {
      indexS = i;
    }
  }
  /*find location of assignment name in array*/
  for (j = 0; j < g->number_of_assignments; j++) {
    if (strcmp(g->assignment_names[j], aName) == 0) {
      indexA = j;
    }
  }
  /*add score*/
  g->scores[indexS][indexA] = score;
  return 1;
}

/*computes average of scores for specific student and assigns letter grade*/
int get_avg_and_letter_grade(Gradebook *g, const char *sName, int *avg, char *lg) {
  int i, j, indexP, sum = 0;
  /*NULL checks*/
  if (check_null(g)) {
    printf("Invalid gradebook");
    return 0;
  }
  if (sName == NULL) {
    return 0;
  }
  /*find location of student name in array*/
  for (i = 0; i < g->number_of_students; i++) {
    if (strcmp(g->students[i].name, sName) == 0) {
      indexP = i;
    }
  }
  for (j = 0; j < g->number_of_assignments; j++) {
    sum += g->scores[indexP][j];
  }
  /*compute average*/
  *avg = sum/g->number_of_assignments;
  /* assign letter grade for average ranges*/
  if (*avg <= 100 && *avg >= 90) {
    *lg = 'A';
  } else if (*avg < 90 && *avg >= 80) {
    *lg = 'B';
  } else if (*avg < 80 && *avg >= 70) {
    *lg = 'C';
  } else if (*avg < 70 && *avg >= 60) {
    *lg = 'D';
  } else {
    *lg = 'F';
  }
  return 1;
}

/*computes grade statistics for a given student*/
int get_stats(Gradebook *g, const char *aName, int *min, int *max, int *avg) {
  int i, j, k, l, indexS, sum = 0;
  /*NULL checks*/
  if (check_null(g)) {
    printf("Invalid gradebook");
    return 0;
  }
  if (aName == NULL) {
    return 0;
  }
  /*located assignment index in array*/
  for (i = 0; i < g->number_of_assignments; i++) {
    if (strcmp(g->assignment_names[i], aName) == 0) {
      indexS = i;
    }
  }
  /*calculate the sum and average of scores*/
  for (j = 0; j < g->number_of_students; j++) {
    sum += g->scores[j][indexS];
    *avg = sum/g->number_of_students;
  }
  /*calculate minimum grade in the assignment*/
  for (k = 0; k < g->number_of_students; k++) {
    *min = g->scores[0][indexS];
    if (*min > g->scores[k][indexS]) {
      *min = g->scores[k][indexS];
    }
  }
  /*calculate maximum grade in then assignment*/
  for (l = 0; l < g->number_of_students; l++) {
    *max = g->scores[0][indexS];
    if (*max < g->scores[l][indexS]) {
      *max = g->scores[l][indexS];
    }
  }
  return 1;
}
