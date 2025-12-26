/**
 * Tests for Lua comment extraction and processing utilities.
 */

import { describe, expect, test } from 'bun:test';

import { extractTopComments, stripCommentPrefix } from '@/lib/lua-comments';

const CODE_WITH_COMMENTS = [
    '-- Comment 1',
    '-- Comment 2',
    '',
    '--- Comment 3',
    '-- Comment 4',
    '',
    'some code here',
    'and some more code',
    '-- and comment',
    'and code again',
];
const LINE_COMMENT = '-- Line comment';
const LINE_COMMENT_WITH_SPACES = ' -- Line comment';
const LINE_COMMENT_MULTIDASH = '--- Line comment';

describe('Lua comment handling', () => {
    test('Top comments are extracted correctly', () => {
        const code = CODE_WITH_COMMENTS.join('\n');
        const extracted = extractTopComments(code);
        expect(extracted).toBeDefined();

        const commentLines = extracted.split('\n');
        expect(commentLines.length).toEqual(4);
        expect(commentLines[0]).toBe(CODE_WITH_COMMENTS[0]);
        expect(commentLines[1]).toBe(CODE_WITH_COMMENTS[1]);
        expect(commentLines[2]).toBe(CODE_WITH_COMMENTS[3]);
        expect(commentLines[3]).toBe(CODE_WITH_COMMENTS[4]);
    });

    test('Comment prefix is stripped correctly', () => {
        const stripped = stripCommentPrefix(LINE_COMMENT);
        expect(stripped).toBe('Line comment');

        const strippedWithSpaces = stripCommentPrefix(LINE_COMMENT_WITH_SPACES);
        expect(strippedWithSpaces).toBe('Line comment');

        const strippedMultidash = stripCommentPrefix(LINE_COMMENT_MULTIDASH);
        expect(strippedMultidash).toBe('Line comment');
    });
});
