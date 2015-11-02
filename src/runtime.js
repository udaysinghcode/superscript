var prn = function(s) { console.log(s); };

var type = function(o) {
  if o.type return o.type;
  else {
    switch (typeof o) {
      case 'boolean': return 'Boolean'; break;
      case 'string': return 'String'; break;
      case 'function': return 'Function'; break;
    };
  }
};

var __unbox = function(o) { return o.value; };

var __add = function(a1, a2) { return { type: 'Int', value: a1.value + a2.value } };
var __sub = function(a1, a2) { return { type: 'Int', value: a1.value - a2.value } };
var __mult = function(a1, a2) { return { type: 'Int', value: a1.value * a2.value } };
var __div = function(a1, a2) { return { type: 'Int', value: Math.floor(a1.value / a2.value) } };
var __addf = function(a1, a2) { return { type: 'Float', value: a1.value + a2.value } };
var __subf = function(a1, a2) { return { type: 'Float', value: a1.value - a2.value } };
var __multf = function(a1, a2) { return { type: 'Float', value: a1.value * a2.value } };
var __divf = function(a1, a2) { return { type: 'Float', value: a1.value / a2.value } };

var __equal = function(a1, a2) { return a1.value === a2.value; };
var __neq = function(a1, a2) { return a1.value !== a2.value; };
var __less = function(a1, a2) { return a1.value < a2.value; };
var __leq = function(a1, a2) { return a1.value <= a2.value; };
var __greater = function(a1, a2) { return a1.value > a2.value; };
var __geq = function(a1, a2) { return a1.value >= a2.value; };
var __and = function(a2, a2) { return a1.value && a2.value; };
var __or = function(a1, a2) { return a1.value || a2.value; };