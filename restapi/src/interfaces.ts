import * as express from 'express';

export interface RequestEx extends express.Request {
    username?: any;
    orgname?: any;
    token?: any;
}