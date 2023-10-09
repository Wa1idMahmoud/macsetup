#!/usr/bin/env node

const fs = require('fs');
const project = process.cwd().split('/').pop();
try {
  const package = require(process.cwd() + '/package.json');

  if (package.dependencies.mocha) {
    package.mocha = {
      recursive: true,
      exit: true,
    };
  }

  fs.writeFileSync(
    process.cwd() + '/package.json',
    JSON.stringify(package, undefined, 2)
  );
  console.log('package.json updated');
} catch (error) {
  console.log('No package.json');
}
