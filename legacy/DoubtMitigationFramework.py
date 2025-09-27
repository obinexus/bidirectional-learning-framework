class DoubtMigrationProtocol:
    """
    Handles insights flowing from Level 2 to Level 4 through verb-noun mapping
    """
    
    def __init__(self):
        self.verb_noun_trie = AVLTrieNode()
        self.dag_schema = DirectedAcyclicGraph()
    
    def capture_level2_insight(self, student_insight):
        """
        Level 2 student may not express formally but demonstrates working solution
        """
        # Parse informal expression
        verb_action = self.extract_verb(student_insight)  # "doing", "making", "building"
        noun_object = self.extract_noun(student_insight)  # "website", "art", "blog"
        
        # Map to formal structure
        formal_mapping = {
            'verb': {
                'informal': verb_action,
                'formal_methods': ['getter', 'setter', 'constructor'],
                'protocol': 'action_pattern'
            },
            'noun': {
                'informal': noun_object,
                'formal_class': 'DomainObject',
                'relations': self.find_isomorphic_relations(noun_object)
            }
        }
        
        return formal_mapping
    
    def validate_insight_bidirectional(self, level2_insight, level4_reviewer):
        """
        Level 4 must prove or disprove Level 2's working hypothesis
        """
        # Level 2 shows it works practically
        if level2_insight.works_in_practice:
            
            # Level 4 attempts formal proof
            formal_proof = level4_reviewer.prove(level2_insight)
            
            if formal_proof.is_valid:
                # Both parties capture the insight
                return {
                    'status': 'PROVEN',
                    'level2_credit': True,
                    'level4_validation': True,
                    'insight': self.formalize_terminology(level2_insight)
                }
            elif formal_proof.is_hypothetical:
                # Works but can't be fully proven yet
                return {
                    'status': 'HYPOTHETICAL_PRACTICE',
                    'requires': 'peer_review',
                    'language_barrier': self.identify_communication_gaps()
                }
            else:
                # Dismissed if proven wrong
                return {'status': 'DISMISSED', 'reason': formal_proof.error}
